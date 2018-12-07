Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E7C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 00:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218A02083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 00:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mAzlCfs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218A02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeLGA0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:26:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36325 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLGA0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 19:26:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so1007886pfc.3
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2x/TesVPPmzQq1gtuw3hQ0iX66gQkj63OxfIjnWQn4=;
        b=mAzlCfs6xnzHFH+CGeMPvMsxYHi1Yw2g9xi9ij/RUangfBSxoRXGwCHLww1MeiW08Z
         jze/RlH99UMrv410oNnCezKU4bU1qj1q2y8yqi2SWTedlViiuN+jUkVfbdjZl3ei8Fh9
         eS9r6d4UJOeNAwwf9uqM5AAVBqAEys7JdCDTVchHSSTsTuXHppPfp+O87hWyqTe6BSc1
         tbpWCs5eAojumWiwsscvvVzDU1O3VVikLwpKyKG2vVrmDl60KpzCMAg56ZRHvqZgV7RP
         nSOxs6olasvYnwUhjfqofgqXg2KFiUbMvszMw9m2Ip8rpowrA5ERRi3JuPVSJcq2k2+A
         QcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2x/TesVPPmzQq1gtuw3hQ0iX66gQkj63OxfIjnWQn4=;
        b=T8Hx6Mnq4rUi7m5C+lhaYc33PeGzuh8G4pWhRp3v7eeQ6RzkKhvWisO+eIH0fEOJOR
         g/uvDUeU9xdc3ZVjtcJ70marGlVDidfEfQOgnumLaluCmQGYJeU4uTG37zTS0wxSurjs
         ACjgYYfDG7q4NANlPrqduadYP741taj/6doUIqgHGTu7fTgfQuXx6Zd0q/7RQVdk/fNs
         ZpQz7tA37uJXwk7lZounAasJkkZ7jGbK8lhaV4y/8OvOqHhOXkDubsh1vOxF0jyngP0J
         FWdCYllnqIaGtiy9Eqr3N8H09ni4dl34zmKH7xszKkJewGvz/rxCDP9kf+BKzCjb4xVC
         hsVg==
X-Gm-Message-State: AA+aEWb90bakGneS+ch9gmCewj22TrvW782EwRRWxZU9ElMdpQ+uP5Bl
        mMVgnVZk7cwgBpQy/0QWxFUQZp2KcYY=
X-Google-Smtp-Source: AFSGD/WSFED5eEKmmFqoyB2IU7FsBu7rlRmLMbJCn0AtAGo4+O4ZLSPP0aflHCP2AV1UPE6uqnQw+A==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr70348pgd.49.1544142412004;
        Thu, 06 Dec 2018 16:26:52 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 5sm1865085pfz.149.2018.12.06.16.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 16:26:50 -0800 (PST)
Subject: Re: [GIT PULL] Follow up block fix
To:     Bart Van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <fd37a010-d44e-dab7-4e39-059a339091eb@kernel.dk>
 <1544142034.185366.293.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ee93d591-3476-dff1-590a-6ea74efd8f8b@kernel.dk>
Date:   Thu, 6 Dec 2018 17:26:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544142034.185366.293.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 5:20 PM, Bart Van Assche wrote:
> On Thu, 2018-12-06 at 16:59 -0700, Jens Axboe wrote:
>> Just a single followup fix to the corruption fix from yesterday. We have
>> an exported interface that does direct dispatch, with DM being the sole
>> user of it. Change that to do bypass insert always instead of attempting
>> direct dispatch. This fixes a deadlock that can happen on DM.
>> Additionally, it gets rid of any exported user of direct dispatch, and
>> enables DM to drop any BUSY handling from using the interface.
>>
>> Please pull!
>>
>>
>>   git://git.kernel.dk/linux-block.git tags/for-linus-20181206
> 
> Hi Jens,
> 
> Which branch does that tag correspond to? Even after having run git fetch
> --tags I can't find that tag in your repository.

I pushed it before I sent the email, where are you looking?

http://git.kernel.dk/cgit/linux-block/tag/?h=for-linus-20181206

> Additionally, the patch on your for-linus branch is missing the "Cc:
> stable" and "Reported-by:" tags that you had promised to add. Did I
> look at the wrong branch?

Doh I did - Linus, I'm going to amend the commit with that info and push
it out again, jfyi. Now done.

-- 
Jens Axboe

