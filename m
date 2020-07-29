Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454B9C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 09:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253D220838
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 09:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2JH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:07:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37669 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2JH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 05:07:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id q6so24209786ljp.4;
        Wed, 29 Jul 2020 02:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0ixb1jJgq4PcU3Usk6ZmktN5ND8M3VvBo7EWZku4aSU=;
        b=Apdf3v2D68FwynV5cJZeswSoxaqucrbGWikP0iFCGPdc/1vz5UQeFT0fY8FqtT78Cs
         3QGyEiRJioMXUUJOhtQ/3ksNQt6w9EGqBJ7+nxDcT7Mwx7ZVO2DIrVZ+EC24HT34tApz
         sSFuiGeHBCqB1IqjvDtS28u7DXBXa9nPOonIToLOeu6lq4wC462bVmLV6iyeeIpbDYmK
         ojbES/F03W2LHxmbKAlAXl+UHvVIo+1hJuVO2hkBCrPUVxU3HgVNNGxr0kEXoxbk69zF
         mFnjjdOngyM94FjGI9TtAVSNFEKdX9fY65oZV9XGa/Js2PPQM79iqNWcrhPhVSNltAko
         PTZg==
X-Gm-Message-State: AOAM532Hj6HaDCUicgHMWAEYc7ctu/T9/hUQAojtjFBFlMtKI5d0fRgm
        yorSy8/WkzaiTX+SdGhFuFqam03hW+0=
X-Google-Smtp-Source: ABdhPJz9wf5QNR65CUpnlh+TUZNMEDvEXktIZ0HKeeIx2T09rKAAfP4I9f9dvG9YIgjg0Z8Oj+VLrQ==
X-Received: by 2002:a2e:7601:: with SMTP id r1mr15299166ljc.111.1596013642633;
        Wed, 29 Jul 2020 02:07:22 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.gmail.com with ESMTPSA id s2sm272584ljg.84.2020.07.29.02.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 02:07:22 -0700 (PDT)
Reply-To: efremov@linux.com
To:     Peilin Ye <yepeilin.cs@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20200728141946.426245-1-yepeilin.cs@gmail.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [Linux-kernel-mentees] [PATCH] block/floppy: Prevent
 kernel-infoleak in raw_cmd_copyout()
Message-ID: <40446b2c-3885-1b30-c0b3-5f544a96ed78@linux.com>
Date:   Wed, 29 Jul 2020 12:07:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728141946.426245-1-yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 7/28/20 5:19 PM, Peilin Ye wrote:
> raw_cmd_copyout() is potentially copying uninitialized kernel stack memory
> since it is initializing `cmd` by assignment, which may cause the compiler
> to leave uninitialized holes in this structure. Fix it by using memcpy()
> instead.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2145e15e0557 ("floppy: don't write kernel-only members to FDRAWCMD ioctl output")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Reviewed-by: Denis Efremov <efremov@linux.com>

ptr comes from raw_cmd_copyin and it should be ok to use memcpy.

Jens, could you please take this one to your 5.9 branch?


> ---
> $ pahole -C "floppy_raw_cmd" drivers/block/floppy.o
> struct floppy_raw_cmd {
> 	unsigned int               flags;                /*     0     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	void *                     data;                 /*     8     8 */
> 	char *                     kernel_data;          /*    16     8 */
> 	struct floppy_raw_cmd *    next;                 /*    24     8 */
> 	long int                   length;               /*    32     8 */
> 	long int                   phys_length;          /*    40     8 */
> 	int                        buffer_length;        /*    48     4 */
> 	unsigned char              rate;                 /*    52     1 */
> 	unsigned char              cmd_count;            /*    53     1 */
> 	union {
> 		struct {
> 			unsigned char cmd[16];           /*    54    16 */
> 			/* --- cacheline 1 boundary (64 bytes) was 6 bytes ago --- */
> 			unsigned char reply_count;       /*    70     1 */
> 			unsigned char reply[16];         /*    71    16 */
> 		};                                       /*    54    33 */
> 		unsigned char      fullcmd[33];          /*    54    33 */
> 	};                                               /*    54    33 */
> 
> 	/* XXX 1 byte hole, try to pack */
> 
> 	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> 	int                        track;                /*    88     4 */
> 	int                        resultcode;           /*    92     4 */
> 	int                        reserved1;            /*    96     4 */
> 	int                        reserved2;            /*   100     4 */
> 
> 	/* size: 104, cachelines: 2, members: 14 */
> 	/* sum members: 99, holes: 2, sum holes: 5 */
> 	/* last cacheline: 40 bytes */
> };
> 

It would be nice to add lkml links with discussion on the issue or
https://www.nccgroup.com/us/about-us/newsroom-and-events/blog/2019/october/padding-the-struct-how-a-compiler-optimization-can-disclose-stack-memory/
in addition to pahole output.

>  drivers/block/floppy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 09079aee8dc4..b8ea98f7a9cb 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3126,7 +3126,9 @@ static int raw_cmd_copyout(int cmd, void __user *param,
>  	int ret;
>  
>  	while (ptr) {
> -		struct floppy_raw_cmd cmd = *ptr;
> +		struct floppy_raw_cmd cmd;
> +
> +		memcpy(&cmd, ptr, sizeof(cmd))>  		cmd.next = NULL;
>  		cmd.kernel_data = NULL;
>  		ret = copy_to_user(param, &cmd, sizeof(cmd));
> 

Thanks,
Denis
