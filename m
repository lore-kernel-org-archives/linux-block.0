Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71261C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336E920882
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nCjXtqwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336E920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGCMJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:12:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34513 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCMJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 21:12:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so1079806plz.1
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 18:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=00minA6MxMBZeYTfAdsN3eLKe4mUC4R0GE0vkjb/2o0=;
        b=nCjXtqwgGqgIGENHTNc09CSIrgYfhEbIz+0rvgeY2j8T2dwQv68BacaafsA2t1XGCD
         Sz2lRDqhgmPVgxOa4N5vRukhwFtx4TCWpfCFbLPZnnhsu7UviCuDrRaSdPUNIv9pIkC0
         vj9NOu6ddOIoMa4n/+cq3LCPH7VoEpJ3cudJIG/4sL0olQHKHgx6zjZeWHD23xPlLHhE
         J2fea8lRgscQX5mwKfBcFdrK9QUm5MrlRLvtXMgQuJlSPJ92Cs1w6T80X2cHNC/cLeE1
         BS0HnzuW6/1J1i9m0+MnOBNpILf1IX8oClIguXyhz6KMA5n8HA687MfRNFyxLEkwMXo5
         UJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=00minA6MxMBZeYTfAdsN3eLKe4mUC4R0GE0vkjb/2o0=;
        b=XzvLJL4vnrraqYd9Gn6G4Vm5/fObpm4v+TG3aESrBKxptVDCB5K6XJDzB+oKVYuztt
         7GHve5O0Od45b4EW4HpYTG4HZ29bjeVin3bVCwzt9m1HaA4+AbLczuMg/3LP/KXbetEN
         n/oHFgt0AwLbug5YhcI2bomLqrsBu1IXbkmrq8TjzULfPa5csAI6kvMbx0hlm07VMsFe
         nAKaOWp7IfCp6Pq1QOP5BbJunRPBGecdLuClFIAVdB7qTjaJTRu70rRmnTD/9OM35Q0w
         iA5RNGZVgnaUy5sXQOF/5x0QI0wq2yPrYgSkKKS2XMqEiGWigVgZ/G3vSyhoq8VEl9au
         1shQ==
X-Gm-Message-State: AA+aEWZIhBM25XLZcG8/4m+viVUqpFeA2eihM7spH7WY+beRJxERWMi+
        AFxkMYHAeHlblnsKYUcTImQZhwo21i4=
X-Google-Smtp-Source: AFSGD/XrS9jFeqs7IEbBFb0511TaPw5ELqZxiPkaj/DLZMlXUyz0MRgeCwAukppNZzGFSP+AeYfnyA==
X-Received: by 2002:a17:902:680f:: with SMTP id h15mr409972plk.40.1544148728089;
        Thu, 06 Dec 2018 18:12:08 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm2305064pfa.38.2018.12.06.18.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 18:12:06 -0800 (PST)
Subject: Re: [GIT PULL] Follow up block fix
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <fd37a010-d44e-dab7-4e39-059a339091eb@kernel.dk>
 <1544142034.185366.293.camel@acm.org>
 <ee93d591-3476-dff1-590a-6ea74efd8f8b@kernel.dk>
 <1544142690.185366.296.camel@acm.org>
 <6f48f48f-10c0-07db-4e90-b310c87554b6@kernel.dk>
Message-ID: <11e4cade-3c46-8537-dc92-b7bf510f1fd7@kernel.dk>
Date:   Thu, 6 Dec 2018 19:12:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6f48f48f-10c0-07db-4e90-b310c87554b6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 5:33 PM, Jens Axboe wrote:
> On 12/6/18 5:31 PM, Bart Van Assche wrote:
>> On Thu, 2018-12-06 at 17:26 -0700, Jens Axboe wrote:
>>> On 12/6/18 5:20 PM, Bart Van Assche wrote:
>>>> Which branch does that tag correspond to? Even after having run git fetch
>>>> --tags I can't find that tag in your repository.
>>>
>>> I pushed it before I sent the email, where are you looking?
>>>
>>> http://git.kernel.dk/cgit/linux-block/tag/?h=for-linus-20181206
>>
>> On my development system git has been configured to fetch from the following repository:
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/
>>
>> Should I fetch your branches from the git.kernel.dk repository instead?
> 
> Ah I see, I always push to git.kernel.dk, and that syncs to git.kernel.org
> only every hour or so. So either one will work, but you might be a bit
> behind if you use git.kernel.org.

Linus, I just know notice you are not on the CC for the discussion about
the patch. Don't pull this one yet. It'll solve the issue, but it'll also
mess up the BUSY feedback loop that DM relies on for good merging of
sequential IO. Testing a new patch now, will push it to you when folks
are happy and when my testing has completed.

-- 
Jens Axboe

