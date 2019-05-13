Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65512C04AA7
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 22:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3259F206A3
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 22:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="QUhu2ETd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEMWMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 18:12:39 -0400
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:53296 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfEMWMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 18:12:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 78F2BA2B2E;
        Tue, 14 May 2019 00:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1557785556; i=@fjfi.cvut.cz;
        bh=g9S36xbdW948QIK3JgulE0p3qRSyqlSp+JKJwveRQq8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=QUhu2ETduwZWvfEErEJRovsjYZwIvZQOJT6bN6t+F/jcATlBDvig3vfcDVm5J+GO9
         XLi1faC1MBp73LB9oi9Wv5pBcUK1G8Qvwr1eXmrXtbtV5TORWNH7xgEGmbEVt9czNU
         Qd2bulSbzbXNF8iGNn+lOkwX67rDadZTbYSQEntQ=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id W_wKxaUaIzZh; Tue, 14 May 2019 00:12:34 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 20EFFA2B1E;
        Tue, 14 May 2019 00:12:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 20EFFA2B1E
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 675B36004D; Tue, 14 May 2019 00:12:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 546F16002A;
        Tue, 14 May 2019 00:12:33 +0200 (CEST)
Date:   Tue, 14 May 2019 00:12:33 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Scott Bauer <sbauer@plzdonthack.me>
cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
In-Reply-To: <20190505144330.GB1030@hacktheplanet>
Message-ID: <alpine.LRH.2.21.1905132354150.6401@linux.fjfi.cvut.cz>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz> <20190501134917.GC24132@infradead.org> <alpine.LRH.2.21.1905032058110.30331@linux.fjfi.cvut.cz> <20190505144330.GB1030@hacktheplanet>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 5 May 2019, Scott Bauer wrote:

> On Fri, May 03, 2019 at 10:32:19PM +0200, David Kozub wrote:
>> On Wed, 1 May 2019, Christoph Hellwig wrote:
>>
>>>> I successfully tested toggling the MBR done flag and writing the shadow MBR
>>>> using some tools I hacked together[4] with a Samsung SSD 850 EVO drive.
>>>
>>> Can you submit the tool to util-linux so that we get it into distros?
>>
>> There is already Scott's sed-opal-temp[1] and a fork by Jonas that adds
>> support for older version of these new IOCTLs[2]. There was already some
>> discussion of getting that to util-linux.[3]
>>
>> While I like my hack, sed-opal-temp can do much more (my tool supports just
>> the few things I actually use). But there are two things which sed-opal-temp
>> currently lacks which my hack has:
>>
>> * It can use a PBKDF2 hash (salted by disk serial number) of the password
>>   rather than the password directly. This makes it compatible with sedutil
>>   and I think it's also better practice (as firmware can contain many
>>   surprises).
>>
>> * It contains a 'PBA' (pre-boot authorization) tool. A tool intended to be
>>   run from shadow mbr that asks for a password and uses it to unlock all
>>   disks and set shadow mbr done flag, so after restart the computer boots
>>   into the real OS.
>>
>> @Scott: What are your plans with sed-opal-temp? If you want I can update
>> Jonas' patches to the adapted IOCTLs. What are your thoughts on PW hashing
>> and a PBA tool?
>
> I will accept any and all patches to sed opal tooling, I am not picky. I will
> also give up maintainership of it is someone else feels they can (rightfully
> so) do a better job.
>
> Jon sent me a patch for the tool that will deal with writing to the shadow MBR,
> so once we know these patches are going in i'll pull that patch into the tool.
>
> Then I guess that leaves PBKDF2 which I don't think will be too hard to pull in.

After (if) these patches are accepted, I can create a patch that adds it 
to sed-opal-temp.

> With regard to your PBA tool, is that actually being run post-uefi/pre-linux?
> IE are we writing your tool into the SMBR and that's what is being run on bootup?

It's actually nothing fancy: It's just a linux program that asks for a 
password and then uses it to unlock all block devices. It's intended to be 
run from an initramfs. So the idea is you build a kernel + initramfs with 
the tool so that the tool it started and after the tool returns, initramfs 
does a reboot. This could be replaced just by a shell script, though then 
you'd have to pass the password from the shell script to e.g. 
sed-opal-temp.

But I think it covers the simple scenario: booting from a locked drive 
with just one locking range. Possibly with other locked drives connected 
that also have one locking range and use the same password (when using pwd 
hash at least the Opal key is not the same).

> Jon, if you think it's a good idea can you ask David if Revanth or you wants
> to take over the tooling? Or if anyone else here wants to own it then let me know.

I got invoved in this just to scratch an itch so I would not be a good 
candidate.

Best regards,
David
