Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D1C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 04:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ACF21850
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 04:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YhA8wkhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLSEc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:32:27 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33969 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLSEc1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 23:32:27 -0500
Received: by mail-pf1-f172.google.com with SMTP id h3so9230454pfg.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 20:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Eba0mjjypEjbuZ72sKaUTFdFDAsmCoihdXRZ8dEThkI=;
        b=YhA8wkhIIe2W4UibcP4akei767FvNf8BezcR0iVISuxGQAZBfrg3W5Cunfza2aW+nk
         N0ZbkuQEIAhadKC5So+RoMQBJOWOhEW4mDByb5CEzIGRSlO8lgvTG/Efv4g/PD66Qf63
         imckUBwSbbbG6YFxIVbiST3WwQNcxuXQvS4iDNWdZeB592UQnSKZmhZ51zn7JjFm3/K2
         eo8rQS//ahlQB5yfkJLmB71AKBnGLxLCoMWeXmWclYFQ+wrtkA214hCCi8+WOMeES0/O
         zR5WkOyiK7erTtyghX6Rh2TAaMM9T2vg+titKTIGPAhvl5fOwsqLeXJNqaff5NOPvI2i
         z12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eba0mjjypEjbuZ72sKaUTFdFDAsmCoihdXRZ8dEThkI=;
        b=D9zPvwRc85qDhWR1LDQQshea/6v6PY7TvYLJ3jM4mNjqoRF4/kLX37vjT9XTw9SoGE
         Jo1EzLIoqUeSQTTgpH0gn/TNGLJzWQgnIwrahqlhMXmMvuBjpslXd+atGcez/oNuvqlj
         kBBRUUxZXw0ZZds8/EPI3aP0vqPRzG1uBLh8OCgGT+J4oGz+gR0PwIxcPGyocDRb1kCU
         SbCT5ZaI9ZNsB41z/NsvuEl9XG0zjP7CRtdCFh1u7l3SXHvefvIhHjgqKPor6ax6n6TW
         4Wf1wjtQVc3ZWXYgjmIKkIx9xmciQVcJk1Pwp2qiD1bpnr3EJWyb0CQfGF6a6oR54N9m
         YbsA==
X-Gm-Message-State: AA+aEWaNcg8XdmZNksGuqyKbStJRalepAZgHpWzsmqvgy3P2dye5ED5r
        XbP2YoB4xiyyZ2yrusEglioQGQ==
X-Google-Smtp-Source: AFSGD/XTO6gbVyhvCwATfMglHaU8ar0y5CL0Y0Ug5MQPmfeKSgq7xd0fROis44CJkZSTAhRlrT5www==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr17978648pgh.6.1545193946872;
        Tue, 18 Dec 2018 20:32:26 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v62sm28862284pfd.163.2018.12.18.20.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 20:32:25 -0800 (PST)
Subject: Re: block: percpu ref (blkg_release) <= 0 (0) after switching to
 atomic
To:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
References: <20181219032520.GA4451@ming.t460p>
 <20181219032738.GB4451@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d404262-007c-2229-ed65-e1c52ed56d85@kernel.dk>
Date:   Tue, 18 Dec 2018 21:32:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219032738.GB4451@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 8:27 PM, Ming Lei wrote:
> On Wed, Dec 19, 2018 at 11:25:21AM +0800, Ming Lei wrote:
>> Hi Jens and Dennis,
>>
>> The following warning can be triggered on for-4.21/block when running
>> xfstests generic/475(xfs), and it is introduced by recent Dennis's patches.
>>
>> test disk: virtio-blk
>> scratch: nvme-pci disk
> 
> oops, the test disk is virtio-scsi, and seems it isn't easy to trigger
> on virtio-blk.

I can reproduce this. Dennis is looking at it, we'll get this solved one
way or another tomorrow.

Thanks for reporting!

-- 
Jens Axboe

