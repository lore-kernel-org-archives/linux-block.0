Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01CBC4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D472089F
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 15:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hSt/q9cF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbfIIPdx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:33:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35392 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfIIPdw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 11:33:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id t50so13387943edd.2
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2019 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tX39vCDSkkvZoKBIPPfW2R+w2FUURYhZfDSDCgbOhrc=;
        b=hSt/q9cFk94UirkKtEnOENDNCkbZlZljEyvQx74ln98oe88bI3AruBfdc4zEZCcKpW
         BuScHEHX7eonvoe6i2kgnDTVwQj778oR11smvTbpSSbSGa8bPnG7iPmCD70msdMgN+Hb
         O7ZrI63l0fPeJKpZsjAYV9aPsp1ERAVazSMuEYOm+QYN/1qr1eYLHrqnaC0jtubhUatV
         VavROX/Idv3rLoeJbSiED43WpIcmYIImLzPx4SP+fQCsHv0o0g4gZv69bXuK89fZ1IHg
         iPl7XhOCVWfKlqWKvDWocUXgzpIaCps/LiqLeGsTRBGTt4B2r7Ohp0WcwF23wyKO24sF
         Detg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tX39vCDSkkvZoKBIPPfW2R+w2FUURYhZfDSDCgbOhrc=;
        b=iXd/JA7yUkLfEVdzufMm8M1WjbDowmJiiSGAVOTPm35cRBvQHjTUcnTKDoLIq0Hr5x
         i+IcbprVhBen2YZ9QTEBCSi0zHjlEdVS2nD2Vt9gthmqxJpLICj3tck0wc3NlO7hAKzy
         k7Z4FmdoD5b6lhdmcGwdS2ZyXtDCMKAijK8qAHEhSJlaskBP7MMcNgFvL9XF9BLJiUp5
         qw8VWsSlSsHCtDvchgfognXlR9HhjrKf+Pr/SOln2sF3fn5nWh+2Pr8InahHn9flkR1p
         DBbh9pp5FICwEJvAq4tqxvrsyuJ/RoDvDsLG8i/rwiV8EUHjR9bAS/gZrp3DxSVhqI/i
         I26Q==
X-Gm-Message-State: APjAAAVI4YlttyHQnloV8ZHKaww2A69ZtPMbWJZtYek9RWHkxChxDqOB
        KsaxrhldKXRpGUVNZlVec7rSog==
X-Google-Smtp-Source: APXvYqxoAdHFTQMPVXUsYblRW6tbTk+IaiVf/AbrFksUI3DhD94I3Tv7tAWgmpQebW7f/n7k/baa4w==
X-Received: by 2002:a17:906:3553:: with SMTP id s19mr19679171eja.163.1568043229011;
        Mon, 09 Sep 2019 08:33:49 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:d8:76cc:10d1:1b4d? ([2001:1438:4010:2540:d8:76cc:10d1:1b4d])
        by smtp.gmail.com with ESMTPSA id h58sm3043027edb.43.2019.09.09.08.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 08:33:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] md: add feature flag MD_FEATURE_RAID0_LAYOUT
To:     NeilBrown <neilb@suse.de>, Coly Li <colyli@suse.de>,
        Song Liu <songliubraving@fb.com>
Cc:     NeilBrown <neilb@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
 <87blwghhq7.fsf@notabene.neil.brown.name>
 <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com>
 <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de>
 <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com>
 <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de>
 <87pnkaardl.fsf@notabene.neil.brown.name>
 <87lfuyarcb.fsf@notabene.neil.brown.name>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b68b130c-3155-22c4-d986-b80da9dc47f7@cloud.ionos.com>
Date:   Mon, 9 Sep 2019 17:33:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87lfuyarcb.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Neil,

On 9/9/19 8:58 AM, NeilBrown wrote:
> 
> Due to a bug introduced in Linux 3.14 we cannot determine the
> correctly layout for a multi-zone RAID0 array - there are two
> possibiities.

possibilities.

> 
> It is possible to tell the kernel which to chose using a module
> parameter, but this can be clumsy to use.  It would be best if
> the choice were recorded in the metadata.
> So add a feature flag for this purpose.
> If it is set, then the 'layout' field of the superblock is used
> to determine which layout to use.
> 
> If this flag is not set, then mddev->layout gets set to -1,
> which causes the module parameter to be required.

Could you point where the flag is set? Thanks.

> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   drivers/md/md.c                | 13 +++++++++++++
>   drivers/md/raid0.c             |  2 ++
>   include/uapi/linux/raid/md_p.h |  2 ++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1f70ec595282..a41fce7f8b4c 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1232,6 +1232,8 @@ static int super_90_validate(struct mddev *mddev, struct md_rdev *rdev)
>   			mddev->new_layout = mddev->layout;
>   			mddev->new_chunk_sectors = mddev->chunk_sectors;
>   		}
> +		if (mddev->level == 0)
> +			mddev->layout = -1;
>   
>   		if (sb->state & (1<<MD_SB_CLEAN))
>   			mddev->recovery_cp = MaxSector;
> @@ -1647,6 +1649,10 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
>   		rdev->ppl.sector = rdev->sb_start + rdev->ppl.offset;
>   	}
>   
> +	if ((le32_to_cpu(sb->feature_map) & MD_FEATURE_RAID0_LAYOUT) &&
> +	    sb->level != 0)
> +		return -EINVAL;
> +
>   	if (!refdev) {
>   		ret = 1;
>   	} else {
> @@ -1757,6 +1763,10 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
>   			mddev->new_chunk_sectors = mddev->chunk_sectors;
>   		}
>   
> +		if (mddev->level == 0 &&
> +		    !(le32_to_cpu(sb->feature_map) & MD_FEATURE_RAID0_LAYOUT))
> +			mddev->layout = -1;
> +
>   		if (le32_to_cpu(sb->feature_map) & MD_FEATURE_JOURNAL)
>   			set_bit(MD_HAS_JOURNAL, &mddev->flags);
>   
> @@ -6852,6 +6862,9 @@ static int set_array_info(struct mddev *mddev, mdu_array_info_t *info)
>   	mddev->external	     = 0;
>   
>   	mddev->layout        = info->layout;
> +	if (mddev->level == 0)
> +		/* Cannot trust RAID0 layout info here */
> +		mddev->layout = -1;
>   	mddev->chunk_sectors = info->chunk_size >> 9;
>   
>   	if (mddev->persistent) {
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index a8888c12308a..6f095b0b6f5c 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -145,6 +145,8 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
>   
>   	if (conf->nr_strip_zones == 1) {
>   		conf->layout = RAID0_ORIG_LAYOUT;
> +	} else if (mddev->layout == RAID0_ORIG_LAYOUT ||
> +		   mddev->layout == RAID0_ALT_MULTIZONE_LAYOUT) {

Maybe "conf->layout = mddev->layout" here? Otherwise seems conf->layout is not set accordingly, just 
my 2 cents.

>   	} else if (default_layout == RAID0_ORIG_LAYOUT ||
>   		   default_layout == RAID0_ALT_MULTIZONE_LAYOUT) {
>   		conf->layout = default_layout;
> diff --git a/include/uapi/linux/raid/md_p.h b/include/uapi/linux/raid/md_p.h
> index b0d15c73f6d7..1f2d8c81f0e0 100644
> --- a/include/uapi/linux/raid/md_p.h
> +++ b/include/uapi/linux/raid/md_p.h
> @@ -329,6 +329,7 @@ struct mdp_superblock_1 {
>   #define	MD_FEATURE_JOURNAL		512 /* support write cache */
>   #define	MD_FEATURE_PPL			1024 /* support PPL */
>   #define	MD_FEATURE_MULTIPLE_PPLS	2048 /* support for multiple PPLs */
> +#define	MD_FEATURE_RAID0_LAYOUT		4096 /* layout is meaningful for RAID0 */
>   #define	MD_FEATURE_ALL			(MD_FEATURE_BITMAP_OFFSET	\
>   					|MD_FEATURE_RECOVERY_OFFSET	\
>   					|MD_FEATURE_RESHAPE_ACTIVE	\
> @@ -341,6 +342,7 @@ struct mdp_superblock_1 {
>   					|MD_FEATURE_JOURNAL		\
>   					|MD_FEATURE_PPL			\
>   					|MD_FEATURE_MULTIPLE_PPLS	\
> +					|MD_FEATURE_RAID0_LAYOUT	\
>   					)
>   
>   struct r5l_payload_header {
> 

Thanks,
Guoqing
