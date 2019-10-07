Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD5ECE58C
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9772820673
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 16:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pY9FMG4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfJGQTn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:19:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44469 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 12:19:42 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so29788595iol.11
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2019 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=213MsUx4Epqsw/9PAh3qE+IhOWt3M83XBYwgzY62qw8=;
        b=pY9FMG4UGrIntco39xCEw5vo0uc88GOvorIZUOt3zxZp13hw70y+pZe7p3PuZBgmPa
         t0W76b1db7hNPTpKsqj6zxAutfBjhtPpaiDOAGWVUUeLC25eZB+nrFPnWi6FIZYqLM8g
         o6/DMqtyYIXeahmoUK2O5KomLooZWEwavhVssd+qyCXhmanxA4kaoEHvr6c+ceZ+y6cG
         OjrRM8hkoudWSv+PDmtcSolt/rkVMxcoz0e/pCfhlXrMkIBSsGvbinZur8fQJrOnHhZQ
         9zRCYOxD7XlHtjPOv2OzKTh1vxjeuu6pX8FLxky8VXtmwlLdT9TeYb9lLYKvJkc8gaoI
         17tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=213MsUx4Epqsw/9PAh3qE+IhOWt3M83XBYwgzY62qw8=;
        b=V+AhNQtEC1hOLxX/UOZzhSlkGOvYHhjCmzhlQQwiI7z6YRNdVNBDlKBMI4dnAcZpz2
         /B1I0l6ksDmztigSJ9hMXtDoRL3spYQCJyzQ/TVa9+p+0+Dl/5uCFSZvyR4z9fHrFAkC
         STWSOenj0fOWo0XgLYcoWZFbUTQ7hSkCBS1iiwa5ikO6TckJiB7cuA1NTWIr4P73Nx+4
         OBjdlJHZFYqR9ogzhXGlxOVu+XXutLnNjDcfOlClULtmO/y04CgOqm1OQv9vMSE8Qgk6
         L6aj9X6koewzKvyU740JRrE83frukQ9FHlW2ogkN8nd4F05e7UVNhPOv8Pe5iscITzhh
         yI6A==
X-Gm-Message-State: APjAAAWutkxcZCGAQSByl4jKscI78pkGRlZfdWQqRiXFTUAymjZP5Qox
        3ePdyM5QDmJDVdzgOkKY6LAWCFOzKRnOvw==
X-Google-Smtp-Source: APXvYqxZtgBYcBfRXiyJm9x+fXmrC7KPfzhUoHSeRFonKOIZXKDLGc5Wj64ScRecXZ9/8Qh7pMhHVQ==
X-Received: by 2002:a92:3a12:: with SMTP id h18mr28893199ila.124.1570465181535;
        Mon, 07 Oct 2019 09:19:41 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b3sm6346493iln.42.2019.10.07.09.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:19:40 -0700 (PDT)
Subject: Re: packet writing support
To:     Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
 <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
 <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
 <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
 <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
 <71a450ed-3f52-fb3a-b0fa-3a08bdc4b3f6@suse.de>
 <977cedab873dfe0705701b3b43c621a7a516e396.camel@cyberfiber.eu>
 <ce56abfd-f309-5471-0201-6226731fa452@suse.de>
 <6eb30ce355f90eca126cbd2f11d359db2bbe69f1.camel@cyberfiber.eu>
 <9596b5fe35dbab5f7804308167bb67b5e6cde52b.camel@cyberfiber.eu>
 <844e6f57-d97d-0c2e-1493-a356cd792a8a@acm.org>
 <62ffa873794d2d6ced83bfc2a59d172677ef815c.camel@cyberfiber.eu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e507eb38-becf-b6a5-bb51-14f873aca28d@kernel.dk>
Date:   Mon, 7 Oct 2019 10:19:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <62ffa873794d2d6ced83bfc2a59d172677ef815c.camel@cyberfiber.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/19 10:13 AM, Mischa Baars wrote:
> On Mon, 2019-10-07 at 07:22 -0700, Bart Van Assche wrote:
>> On 2019-10-07 02:17, Mischa Baars wrote:
>>> On Mon, 2019-10-07 at 11:11 +0200, Mischa Baars wrote:
>>>> necesarry
>>>
>>> a) If necessary I could do the maintaining, sure.
>>
>> You may want to start with having a look at the following:
>> * pktcdvd: invalid opcode 0000 kernel BUG in pkt_make_request
>> (https://bugzilla.kernel.org/show_bug.cgi?id=201481)
>> * pktcdvd triggers a lock inversion complaint
>> (https://bugzilla.kernel.org/show_bug.cgi?id=202745)
>>
>> Thanks,
>>
>> Bart.
> 
> I'm unable to reproduce these findings, also I'm unable to find any
> executable or any manpage called pktsetup.

Let's put this to rest. You are not using pktcdvd in your current setup.
You have apparently stumbled into some cdrom/dvd related regression if
the burning stopped working for you, please see:

Documentation/admin-guide/reporting-bugs.rst

in the kernel tree for how to report that bug, separately. No further
emails are needed in this thread.

-- 
Jens Axboe

