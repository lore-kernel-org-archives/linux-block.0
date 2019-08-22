Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0A2C3A59D
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 08:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC5822CE3
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 08:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="GIl7zRle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfHVItz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:49:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37893 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbfHVItz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 04:49:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so6832022edo.5
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2019 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GB3BnyX//0LxQUlKZs1v5lBLtwZq+I1BzkyauFnkReM=;
        b=GIl7zRle9i0EKht1Uzvu/mFqu4kZOQg45K+ctg9n4+TY1CqIcwBcEbsnBkAdGUaQTY
         Tfqwq8L/1hg79X3UoVdHfw9/GnGVR5FOqRV1knbsHHHNwWno1VEfIlPvIJIfUNE+8107
         MzIPGen33ngySUAzd8vc56pak69gvF+rOLvGq3FkeDtgTBqEiQszrs4zCPcORRmszq3T
         z+vUiH3a82s9N5vgIX/Q0twetwuFiwtEg87dZfjQQbIDdTHlUFTh3umJUqi4gpnszVHD
         GoWy8r8C55UqiQyT2Hy0pk8oEhWh9zFZAnrYOFLytFOaPWbU+ytl9U3oO+EIIx52fy4A
         dyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GB3BnyX//0LxQUlKZs1v5lBLtwZq+I1BzkyauFnkReM=;
        b=OxUeMhJ2k1HBy9g+F73D6RBorljteGzKVRIskcoyzj2I8vGx10C9aBZYjU2Oh24qJY
         TYjj4H5TImQ3Jv1iVJeEmlnc+vWKzuivqpKNrywRDB/SluchePVDpmJ0EPzNRAwLLrCV
         KrV6BccF1X3LLvJm8bKxy8aZ6ZTedTwbO5/9kjeA+dbQNVgoYwLtKK2qJ36fNfDeZsRv
         Mk5S5OLsyecoXYmTQ/oSybWb1vXsIEtYqJOMBOWajaZG2Ah1Htw8JKs/ULx/+08gJM+B
         8Wb5c1wxLxR4/X5r6aoGi19yhPwgVceXAJGfDtpZ80X1xosI1xrW27EsE23lLiyhAffj
         KOpQ==
X-Gm-Message-State: APjAAAU1HUqWDsu1sD3ntQgJV0PKUVqn5eTugEQ/yDfaRi8PblV14yij
        0o7dGgohOt3LTXolbpfmk1NQYA==
X-Google-Smtp-Source: APXvYqxbm7VmKEK9AjIgqdGk2W27jQvIU5lbFU+j3iGT6v4bhB05KXOOtrjr3CKqcfVDi/ILILf38g==
X-Received: by 2002:a17:906:70c3:: with SMTP id g3mr30062420ejk.195.1566463793384;
        Thu, 22 Aug 2019 01:49:53 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:a882:5953:17cf:1b5f? ([2001:1438:4010:2540:a882:5953:17cf:1b5f])
        by smtp.gmail.com with ESMTPSA id ns22sm3556760ejb.9.2019.08.22.01.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 01:49:52 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        jay.vosburgh@canonical.com, NeilBrown <neilb@suse.com>,
        Song Liu <songliubraving@fb.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <ca2096ca-8cb2-468f-89d4-24cd059b8a6b@cloud.ionos.com>
Date:   Thu, 22 Aug 2019 10:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816134059.29751-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 8/16/19 3:40 PM, Guilherme G. Piccoli wrote:
> +static bool linear_is_missing_dev(struct mddev *mddev)
> +{
> +	struct md_rdev *rdev;
> +	static int already_missing;
> +	int def_disks, work_disks = 0;
> +
> +	def_disks = mddev->raid_disks;
> +	rdev_for_each(rdev, mddev)
> +		if (rdev->bdev->bd_disk->flags & GENHD_FL_UP)
> +			work_disks++;
> +
> +	if (unlikely(def_disks - work_disks)) {

If my understanding is correct, after enter the branch,

> +		if (already_missing < (def_disks - work_disks)) {

the above is always true since already_missing should be '0', right?
If so, maybe the above checking is pointless.

> +			already_missing = def_disks - work_disks;
> +			pr_warn("md: %s: linear array has %d missing/failed members\n",
> +				mdname(mddev), already_missing);
> +		}
> +		return true;
> +	}
> +
> +	already_missing = 0;
> +	return false;
> +}
> +.

I'd suggest something like, just FYI.

bool already_missing = false;
int missing_disks;

missing_disks = def_disks - work_disks;
if (unlikely(missing_disks)) {
	already_missing = true;
	pr_warn("md: %s: linear array has %d missing/failed members\n", mdname(mddev), missing_disks);
}
return already_missing;


Thanks,
Guoqing

