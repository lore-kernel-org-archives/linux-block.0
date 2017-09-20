Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:35945 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbdITS2h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2017 14:28:37 -0400
Date: Wed, 20 Sep 2017 21:28:34 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: <mb@lightnvm.io>, <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH 08/20] lightnvm: pblk: sched. metadata on write thread
Message-ID: <20170920182834.GA25232@dhcp-216.srv.tuxera.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
 <1498471049-25505-9-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1498471049-25505-9-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Javier,

one small issue I found for error path while going through changes:

On Mon, Jun 26, 2017 at 11:57:17AM +0200, Javier Gonz�lez wrote:
..
> +static int pblk_lines_alloc_metadata(struct pblk *pblk)
> +{
> +	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	int i;
> +
> +	/* smeta is always small enough to fit on a kmalloc memory allocation,
> +	 * emeta depends on the number of LUNs allocated to the pblk instance
> +	 */
> +	l_mg->smeta_alloc_type = PBLK_KMALLOC_META;
> +	for (i = 0; i < PBLK_DATA_LINES; i++) {
> +		l_mg->sline_meta[i] = kmalloc(lm->smeta_len, GFP_KERNEL);
> +		if (!l_mg->sline_meta[i])
> +			goto fail_free_smeta;

For this error path the the goto label at end doesn't free up
resources correctly.  It needs a

while (--index >= 0)...

logic with appropriate adjustment.

> +	}
> +
> +	/* emeta allocates three different buffers for managing metadata with
> +	 * in-memory and in-media layouts
> +	 */
> +	for (i = 0; i < PBLK_DATA_LINES; i++) {
> +		struct pblk_emeta *emeta;
> +
> +		emeta = kmalloc(sizeof(struct pblk_emeta), GFP_KERNEL);
> +		if (!emeta)
> +			goto fail_free_emeta;
> +
> +		if (lm->emeta_len[0] > KMALLOC_MAX_CACHE_SIZE) {
> +			l_mg->emeta_alloc_type = PBLK_VMALLOC_META;
> +
> +			emeta->buf = vmalloc(lm->emeta_len[0]);
> +			if (!emeta->buf) {
> +				kfree(emeta);
> +				goto fail_free_emeta;
> +			}
> +
> +			emeta->nr_entries = lm->emeta_sec[0];
> +			l_mg->eline_meta[i] = emeta;
> +		} else {
> +			l_mg->emeta_alloc_type = PBLK_KMALLOC_META;
> +
> +			emeta->buf = kmalloc(lm->emeta_len[0], GFP_KERNEL);
> +			if (!emeta->buf) {
> +				kfree(emeta);
> +				goto fail_free_emeta;
> +			}
> +
> +			emeta->nr_entries = lm->emeta_sec[0];
> +			l_mg->eline_meta[i] = emeta;
> +		}
> +	}
> +
> +	l_mg->vsc_list = kcalloc(l_mg->nr_lines, sizeof(__le32), GFP_KERNEL);
> +	if (!l_mg->vsc_list)
> +		goto fail_free_emeta;
> +
> +	for (i = 0; i < l_mg->nr_lines; i++)
> +		l_mg->vsc_list[i] = cpu_to_le32(EMPTY_ENTRY);
> +
> +	return 0;
> +
> +fail_free_emeta:
> +	while (--i >= 0) {
> +		vfree(l_mg->eline_meta[i]->buf);

This would need l_mg->emeta_alloc_type check to decide whether
allocation was done with kmalloc or vmalloc.

> +		kfree(&l_mg->eline_meta[i]);
> +	}
> +
> +fail_free_smeta:
> +	for (i = 0; i < PBLK_DATA_LINES; i++)
> +		pblk_mfree(&l_mg->sline_meta[i], l_mg->smeta_alloc_type);
> +
> +	return -ENOMEM;
> +}
> +

Thanks,
