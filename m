Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A1DC00140
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 21:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346801AbiHRV1g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346992AbiHRV1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 17:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11BDA3D2
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660857586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0r/rILycb6f0Rg2/ghEzH9yXMuPMwllLxgZf1pOL+8=;
        b=Xj4jUd8/yjSS30DMR3XS6oP5kUwPY1LRfkmgDsUkkTM9RcHi+B1b2vOFj1w2LoVOjiKnrU
        TRXW3+haJezBbzKTuliRvfBlU/lCNd3j73MCEFx7T9SmHsLXheKFINH1jBBhClNNXgxNsP
        vubkMMijev+5lvc7qn8hjxISsZGJJVM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-Km2grLTaPbqXEw9ph1_D2w-1; Thu, 18 Aug 2022 17:19:45 -0400
X-MC-Unique: Km2grLTaPbqXEw9ph1_D2w-1
Received: by mail-io1-f70.google.com with SMTP id f16-20020a6b6210000000b006889725d748so1555352iog.8
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 14:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=W0r/rILycb6f0Rg2/ghEzH9yXMuPMwllLxgZf1pOL+8=;
        b=Am9NEhruOCkKj9fDCHkwlVagORZcDgWhSCo6SXsFkHKLx1EBKUsQ+0XfdyRfNDjZjH
         +N9O8pjdkQTb0NXSyLd1MX0NakZSj17o81QVcW76TRvavHaSJbSwaWu1IaOrXaBAB2Xg
         GVP/CNkVryHCtB//TeRBBAQedH611qDmuDpu0IlCu1yRFSUUZfrBv4EEzNKmHwDDpiV9
         WQ0lREeSnU/Uk6/etwXCPK56tAtB9j0WWN0gp7c//Qpa3+bq6O779W0bixpqaNCeF+Ky
         Mw9SyulsSoMD9SgwwknYJ4vy4YooJj3BeIv18hGAlvwg/f+zWOORKcwavnSAuOaNIxVz
         noAQ==
X-Gm-Message-State: ACgBeo2BWvFNgz3HRuWkDjMQ/ah4mtxIs4HLN7eiF7mIRWi/8RwDEJWO
        eC8VOGcdI+LmH9bbxmfMEo0fzDJt5DFniM43IkCc7LFI1Zzjs9qp9dGmSTmFpJUL1ufykUWbpUU
        O5ZyXg2rce4lHIz9y4pyr9Yw=
X-Received: by 2002:a05:6e02:5d1:b0:2e7:1a94:e779 with SMTP id l17-20020a056e0205d100b002e71a94e779mr2172099ils.173.1660857584737;
        Thu, 18 Aug 2022 14:19:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7SX4gpV8g3GPH3QVVZ8bTPM4qn9RBdCQKxpR3vB09Q2AZ3KhifNqgkLbtnE0ijqsYpe0ZxdA==
X-Received: by 2002:a05:6e02:5d1:b0:2e7:1a94:e779 with SMTP id l17-20020a056e0205d100b002e71a94e779mr2172091ils.173.1660857584425;
        Thu, 18 Aug 2022 14:19:44 -0700 (PDT)
Received: from [10.0.0.146] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id l1-20020a056e02066100b002dd1b9f32c0sm1020523ilt.78.2022.08.18.14.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 14:19:44 -0700 (PDT)
Message-ID: <974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com>
Date:   Thu, 18 Aug 2022 16:19:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: LTP test df01.sh detected different size of loop device in v5.19
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.de>,
        linux-xfs@vger.kernel.org, ltp@lists.linux.it
References: <YvZc+jvRdTLn8rus@pevik> <YvZUfq+3HYwXEncw@pevik>
 <YvZTpQFinpkB06p9@pevik> <20220814224440.GR3600936@dread.disaster.area>
 <YvoSeTmLoQVxq7p9@pevik> <8d33a7a0-7a7c-47a1-ed84-83fd25089897@sandeen.net>
 <Yv5Z7eu5RGnutMly@pevik> <f03c6929-9a14-dd58-3726-dd2c231d0981@sandeen.net>
 <Yv5oaxsX6z2qxxF3@magnolia> <Yv5wUcLpIR0hwbmI@pevik>
From:   Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <Yv5wUcLpIR0hwbmI@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/22 12:01 PM, Petr Vorel wrote:
>> On Thu, Aug 18, 2022 at 11:05:33AM -0500, Eric Sandeen wrote:
>>> On 8/18/22 10:25 AM, Petr Vorel wrote:
>>>> Hi Eric, all,
> 
> 
>>> ...
> 
> 
>>>>> IOWS, I think the test expects that free space is reflected in statfs numbers
>>>>> immediately after a file is removed, and that's no longer the case here. They
>>>>> change in between the df check and the statfs check.
> 
>>>>> (The test isn't just checking that the values are correct, it is checking that
>>>>> the values are /immediately/ correct.)
> 
>>>>> Putting a "sleep 1" after the "rm -f" in the test seems to fix it; IIRC
>>>>> the max time to wait for inodegc is 1s. This does slow the test down a bit.
> 
>>>> Sure, it looks like we can sleep just 50ms on my hw (although better might be to
>>>> poll for the result [1]), I just wanted to make sure there is no bug/regression
>>>> before hiding it with sleep.
> 
>>>> Thanks for your input!
> 
>>>> Kind regards,
>>>> Petr
> 
>>>> [1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests
> 
>>>>> -Eric
> 
>>>> +++ testcases/commands/df/df01.sh
>>>> @@ -63,6 +63,10 @@ df_test()
>>>>  		tst_res TFAIL "'$cmd' failed."
>>>>  	fi
> 
>>>> +	if [ "$DF_FS_TYPE" = xfs ]; then
>>>> +		tst_sleep 50ms
>>>> +	fi
>>>> +
> 
>>> Probably worth at least a comment as to why ...
> 
> Sure, that was just to document possible fix. BTW even 200ms was not reliable in
> the long run => not a good solution.
> 
>>> Dave / Darrick / Brian - I'm not sure how long it might take to finish inodegc?
>>> A too-short sleep will let the flakiness remain ...
> 
>> A fsfreeze -f / fsfreeze -u cycle will force all the background garbage
>> collection to run to completion when precise free space accounting is
>> being tested.
> Thanks for a hint, do you mean to put it into df_test after creating file with
> dd to wrap second df_verify (calls df) and df_check (runs stat and compare values)?
> Because that does not help - it fails when running in the loop (managed to break after 5th run).

I think it would go after you remove the file, to ensure that no space usage
changes are pending when you check.

<tests>

This seems to work fine (pseudopatch):

        ROD_SILENT rm -rf mntpoint/testimg

+       # Ensure free space change can be seen by statfs
+       fsfreeze -f $TST_MNTPOINT
+       fsfreeze -u $TST_MNTPOINT

        # flush file system buffers, then we can get the actual sizes.
        sync


(although: what's the difference between $TST_MNTPOINT and mountpoint/ ?)

You just don't want to accidentally freeze the root filesystem ;)

-Eric


