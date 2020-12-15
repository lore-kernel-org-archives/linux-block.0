Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1782C2BBCA
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A421322571
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgLOP5z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 10:57:55 -0500
Received: from mx4.veeam.com ([104.41.138.86]:51820 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbgLOP5x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 10:57:53 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id E19C7B21B0;
        Tue, 15 Dec 2020 18:57:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1608047821; bh=xGX6r6A8Hjl7MCNVKGqT3FZ7eubP6L89FA+xBv0u2dU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=Kmgx22+3snq91e1HH7f8cZ8yFER5ispuPCYFsol/fkmNAycaJmMtni9q3Lp35OBw8
         rbQIoC0V6QmSvIxdkBMzyiWkCfyAgvoAQzRbxCCaXZzSxmuG27m0wHj+u03TpH/O+H
         LuTESvkS3LSH3WET7pOpkhwb++9NSnWJZ0HwrwqE=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Tue, 15 Dec 2020
 16:56:59 +0100
Date:   Tue, 15 Dec 2020 18:57:15 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Bob Liu <bob.liu@oracle.com>
CC:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
Message-ID: <20201215155715.GA2541@veeam.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com>
 <20201210145814.GA31521@veeam.com>
 <20201210163222.GB10239@redhat.com>
 <20201211163049.GC16168@redhat.com>
 <1ee7652e-b77f-6fa4-634c-ff6639037321@kernel.dk>
 <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
 <cdc3c792-17ac-de61-12ae-74691769fc3c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <cdc3c792-17ac-de61-12ae-74691769fc3c@oracle.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A6D756B
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 12/15/2020 09:51, Bob Liu wrote:
> Hi Folks,
> 
> On 12/12/20 12:56 AM, Hannes Reinecke wrote:
> > On 12/11/20 5:33 PM, Jens Axboe wrote:
> >> On 12/11/20 9:30 AM, Mike Snitzer wrote:
> >>> While I still think there needs to be a proper _upstream_ consumer of
> >>> blk_interposer as a condition of it going in.. I'll let others make the
> >>> call.
> >>
> >> That's an unequivocal rule.
> >>
> >>> As such, I'll defer to Jens, Christoph and others on whether your
> >>> minimalist blk_interposer hook is acceptable in the near-term.
> >>
> >> I don't think so, we don't do short term bandaids just to plan on
> >> ripping that out when the real functionality is there. IMHO, the dm
> >> approach is the way to go - it provides exactly the functionality that
> >> is needed in an appropriate way, instead of hacking some "interposer"
> >> into the core block layer.
> >>
> > Which is my plan, too.
> > 
> > I'll be working with the Veeam folks to present a joint patchset (including the DM bits) for the next round.
> > 
> 
> Besides the dm approach, do you think Veeam's original requirement is a good
> use case of "block/bpf: add eBPF based block layer IO filtering"?
> https://lwn.net/ml/bpf/20200812163305.545447-1-leah.rumancik@gmail.com/
> 
> Thanks,
> Bob

Hi Bob.
Thank you for your message.

I looked at your patch - it's interesting, but I have a few comments.

1.
#ifdef CONFIG_BPF_IO_FILTER
	struct bpf_prog_array __rcu *progs;
	struct mutex io_filter_lock;
#endif
For DM and blk-snap to work, it is necessary that there is always
the possibility of interception.

2.
We could get rid of the io_filter_lock lock if we do attach/detach while
the queue is stopped. And __rcu for *progs, can not use either.

3.
int io_filter_bpf_run(struct bio *bio)
{
	struct bpf_io_request io_req = {
		.sector_start = bio->bi_iter.bi_sector,
		.sector_cnt = bio_sectors(bio),
		.opf = bio->bi_opf,
	};
	return BPF_PROG_RUN_ARRAY_CHECK(bio->bi_disk->progs, &io_req, BPF_PROG_RUN);
}
Allows to get little information. It will not allow to work with the bios`s data.
blk_interposer allows to get full access to bio.
For use in the DM, we must also be able to add new bio's.

Summary:
For device-mapper purposes, bpf_io_filter is not suitable.
bpf_io_filter in this form is probably convenient to use for monitoring and
studying the block layer.
For the security task, I would suggest making a separate module and using
blk_interposer to intercept bio requests. This will give more flexible
functionality and better performance.

--
Sergei Shtepa
Veeam Software developer.
