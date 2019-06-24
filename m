Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311D0C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 20:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E606A20674
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 20:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF92zJ7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfFXUEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:04:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41591 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfFXUEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 16:04:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so7480346pls.8;
        Mon, 24 Jun 2019 13:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dk2R3X3mXgvjmuQPVyOAVKaP4L33xF9EDrVfT2sQbNI=;
        b=UF92zJ7xG3gXZJovCYVf6Neju1c/kxLbJj7Ukdnhy/ugZ8KG18znDom6c+Np6xvx1t
         +VgPUVcG5sVGT3Cqme0AZHXiDtl+0SeRMHW8mlJDjrOy9WinZRMnD2BLpb9jSCcRvg7W
         KbMtm4AK3Irwp/TcWD6ckBLrfkvNuLHExILnGvyCGEExP/60BkQJVHzun/UYpsHsiEg6
         tYPuV1QWEmYOEEKYIvx17nZb0vmO0oqVFi39+iDaGWfLpElkmNsXKasobNdfe68ZdYZs
         BiwH66njh+RURv4f9f89bJ83eyrVRkyyw49K0kh8iG5opqMBaMQ9LcVG2NSvMUyYBkxv
         AhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dk2R3X3mXgvjmuQPVyOAVKaP4L33xF9EDrVfT2sQbNI=;
        b=ZpZJsr0c3cB5pmOUW32Yt3HIv8yXbu//znG8vyeTQg25me+acYfnlWyjZuzJlrdPi8
         plk+t8uaMWJVpmbrfAnU2leBsz1IsIUmnZ6DrJ068RUJRauKOKuZuplyqsaHLC/6+OPt
         x8KyzaXkizPORZi0olJ9LZdJjqhaFJnUsbMrBcL61kMrkRf3Cc6zaSZmCIEwsO7hhQSC
         Ba5CBpI1GjD935Gb46Q16ZBGVa40g5/Fjz7NU/hmISu1bUi8yFcxPCagJAwtWgrKaO8P
         EaMKWy6zBI7t5vid5d44WD5rmAV5RR2JLtgdBd4tAAUQuA8gyDX2Yea8dRHY95qq4Tfk
         1AQw==
X-Gm-Message-State: APjAAAUFD2zJhqvBDcPG4cQ16jmZNii3ism4tP2HHkLcNfiTDam7JIxE
        NpYbd7rpyTsBJzh3lcUVko4=
X-Google-Smtp-Source: APXvYqzxuRK2hyiqUt/pzhH0h+MxxhDFe6KzPYHBGUzbDSddM2Mg9/iAlq1QP7VTcyjJ87h3b0S8cg==
X-Received: by 2002:a17:902:e211:: with SMTP id ce17mr68110616plb.193.1561406688219;
        Mon, 24 Jun 2019 13:04:48 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id x14sm14338992pfq.158.2019.06.24.13.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 13:04:47 -0700 (PDT)
Date:   Tue, 25 Jun 2019 05:04:45 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Weiping Zhang <zhangweiping@didiglobal.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, bvanassche@acm.org,
        keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 3/5] nvme-pci: rename module parameter write_queues to
 read_queues
Message-ID: <20190624200445.GB6526@minwooim-desktop>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-06-24 22:29:19, Weiping Zhang wrote:
> Now nvme support three type hardware queues, read, poll and default,
> this patch rename write_queues to read_queues to set the number of
> read queues more explicitly. This patch alos is prepared for nvme
> support WRR(weighted round robin) that we can get the number of
> each queue type easily.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Hello, Weiping.

Thanks for making this patch as a separated one.  Actually I'd like to
hear about if the origin purpose of this param can be changed or not.

I can see a log from Jens when it gets added her:
  Commit 3b6592f70ad7("nvme: utilize two queue maps, one for reads and
                       one for writes")
  It says:
  """
  NVMe does round-robin between queues by default, which means that
  sharing a queue map for both reads and writes can be problematic
  in terms of read servicing. It's much easier to flood the queue
  with writes and reduce the read servicing.
  """

So, I'd like to hear what other people think about this patch :)

Thanks,

> ---
>  drivers/nvme/host/pci.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5d84241f0214..a3c9bb72d90e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -68,10 +68,10 @@ static int io_queue_depth = 1024;
>  module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
>  MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
>  
> -static int write_queues;
> -module_param(write_queues, int, 0644);
> -MODULE_PARM_DESC(write_queues,
> -	"Number of queues to use for writes. If not set, reads and writes "
> +static int read_queues;
> +module_param(read_queues, int, 0644);
> +MODULE_PARM_DESC(read_queues,
> +	"Number of queues to use for reads. If not set, reads and writes "
>  	"will share a queue set.");
>  
>  static int poll_queues;
> @@ -211,7 +211,7 @@ struct nvme_iod {
>  
>  static unsigned int max_io_queues(void)
>  {
> -	return num_possible_cpus() + write_queues + poll_queues;
> +	return num_possible_cpus() + read_queues + poll_queues;
>  }
>  
>  static unsigned int max_queue_count(void)
> @@ -2021,18 +2021,16 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
>  	 * If only one interrupt is available or 'write_queue' == 0, combine
>  	 * write and read queues.
>  	 *
> -	 * If 'write_queues' > 0, ensure it leaves room for at least one read
> +	 * If 'read_queues' > 0, ensure it leaves room for at least one write
>  	 * queue.
>  	 */
> -	if (!nrirqs) {
> +	if (!nrirqs || nrirqs == 1) {
>  		nrirqs = 1;
>  		nr_read_queues = 0;
> -	} else if (nrirqs == 1 || !write_queues) {
> -		nr_read_queues = 0;
> -	} else if (write_queues >= nrirqs) {
> -		nr_read_queues = 1;
> +	} else if (read_queues >= nrirqs) {
> +		nr_read_queues = nrirqs - 1;
>  	} else {
> -		nr_read_queues = nrirqs - write_queues;
> +		nr_read_queues = read_queues;
>  	}
>  
>  	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> -- 
> 2.14.1
> 
