Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6525EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 02:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGKCA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 22:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGKCA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 22:00:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F894
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 19:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD8B612B4
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 02:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCCDC433C8;
        Tue, 11 Jul 2023 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689040857;
        bh=l2hscFblUVpAyfjjjjsEelyTSWlKonNRiDD3zw9mTXM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j5B2L1FsInz2G3qVqNJOuLdDhXP7cSq1TMd6eZM/w5RkSa/FaUWN/jSLGksLRqk08
         8VgfqM083jGGo0T4GtpwAimzeOFCAYrXNWb+eeBNEhE56Kt1zT8XwdjYwaWdBTeesq
         sJNioeRZEuzj2o1mYECloZBKS5w/sumJf3WRG/pBznlJZELRD9HO7Snp2X/+PSLQFv
         lTAxc2L9wxlcGVTUehlk7+L5gcUvPr+z0K4mdTQCdFyg5Xf35RHLdfIuysnpIjxFbt
         wAOorU2Sz6icw//YGHEK8WO+hnbW9FT6eiPQUG6qp6E0X0+gbGBe1iioBNc8zDcKm1
         asOUlkgq/9VZQ==
Message-ID: <4d484518-5822-bd4b-4261-08a3aec6b5d2@kernel.org>
Date:   Tue, 11 Jul 2023 11:00:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org
References: <20230707094028.107898-1-hch@lst.de> <ZKx2jVONy35B0/S1@google.com>
 <c0883104-8472-91b1-b9ad-ec3114bd166c@kernel.org>
 <ZKy15tpRQjja6s/5@google.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZKy15tpRQjja6s/5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/23 10:52, Jaegeuk Kim wrote:
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index ca31163da00a55..8d11d4a5ec331d 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -1560,7 +1560,8 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>>>>  {
>>>>  	int i;
>>>>  
>>>> -	for (i = 0; i < sbi->s_ndevs; i++) {
>>>
>>> #ifdef CONFIG_BLK_DEV_ZONED
>>>
>>>> +	kvfree(FDEV(0).blkz_seq);
>>>
>>> #endif
>>
>> This should not be needed since for the !CONFIG_BLK_DEV_ZONED case,
>> FDEV(0).blkz_seq should always be NULL. However, what I think may be missing is
>> "FDEV(0).blkz_seq = NULL;" after the kvfree() call. No ?
> 
> I was looking at a glance of this:
> https://lore.kernel.org/linux-f2fs-devel/202307110542.NBAMyZxE-lkp@intel.com/T/#u

OK. Got it.
I still think that it may be safer to add the NULL affectation though.


-- 
Damien Le Moal
Western Digital Research

