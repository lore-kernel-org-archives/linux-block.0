Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A08EB64D7
	for <linux-block@archiver.kernel.org>; Sun, 18 Jun 2023 23:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjFRX4t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Jun 2023 19:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRX4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2023 19:56:48 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301FDB
        for <linux-block@vger.kernel.org>; Sun, 18 Jun 2023 16:56:45 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77de67139ccso153775839f.0
        for <linux-block@vger.kernel.org>; Sun, 18 Jun 2023 16:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687132605; x=1689724605;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhbQ/9Lw/d7VRHRatcO6ogwl+kSlam871Nks56VmkhQ=;
        b=HKenFjNgkuMs+fFtU9hz/QdHY5Pj6fk3sU0XrbjdPZWV8uYKAAHoS8WlCejQaupf8K
         GNOjEIrK3iwSNHmmBb3dLKDn5JOl7RhaBfsniqE8lXkL+AG3DsZcVSSwweywV0a64cCI
         TSMA58BX7zIIYc97q4520lbtUClTgh8XRhBnY3fU1MqLP7c8GGnv6fuH8JpSeb4B/mY3
         q/kIGqzbmNhoKgeKy9KJnJP8/ywqsdjhGJIRIpuo2T1ieLp/vhYbLH7c7U3P8E3hi7U5
         7rE8a34PC/syBBUqCjgD8scqsRIgqwjkHLRd9yr2ZBrOrjjxgpKqwTrpJz+EeJAKek9E
         5Eig==
X-Gm-Message-State: AC+VfDxkd3Kp5QXsupg9H+rBZlJMezDyIcz/r2idoEG5zmDT0/PN/al/
        uc+asEu1s96yV2cF3Klha+8HMZ2mGY8=
X-Google-Smtp-Source: ACHHUZ5glNoj0inoIBoMlcuMRLI+ce5l9ywrkbS+kH1FvhON//wJv2pHft+oD2cwcLR7myTGexMC7w==
X-Received: by 2002:a92:ce47:0:b0:342:6935:68b2 with SMTP id a7-20020a92ce47000000b00342693568b2mr1429240ilr.25.1687132605014;
        Sun, 18 Jun 2023 16:56:45 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h33-20020a635321000000b005302682a668sm17196636pgb.17.2023.06.18.16.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 16:56:44 -0700 (PDT)
Message-ID: <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
Date:   Sun, 18 Jun 2023 16:56:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-US
To:     Jaco Kroon <jaco@uls.co.za>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/23 12:34, Jaco Kroon wrote:
> On 2023/06/12 20:40, Bart Van Assche wrote:
>> tar -czf- -C /sys/kernel/debug/block . >block.tgz
>>
> Right on queue ... please find attached.  Not seeing any content in any 
> of the files from the tar czf so I doubt there is much use here ... 
> perhaps you might be able to explain why all of these files under 
> /sys/kernel/debug/block would be empty?

Apparently the tar command is incompatible with debugfs :-( I should 
have tested the command before I sent it to you.

Does this work better?

(cd /sys/kernel/debug/block/ && grep -r . .) | gzip -9 > block.gz

Thanks,

Bart.
