Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B88AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 01:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652626128E
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 01:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhKKBTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 20:19:03 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45916 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhKKBTB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 20:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636593372; x=1668129372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yxG7AS0Kke4Fc/lJ+UMGhKlUwWn7XHRNaQXmVig4wHY=;
  b=K1OS14PiWu3wBn8gTGXdM0rnp7vCgBPTnCxzs7HYV5MAUu1PEoBV12DS
   Vp9k2Nkgo9qhebGjKFpW+d//w+DiJL6EA/G+ExOqRpBElvFwiqk68MEtH
   WLvns+PBNKup7BsgrjXIPrFbJXLbkKzybxYVnisiBNNZ3z+E5wXMAKhZJ
   JZFBsY0p2xbaDdTzO4pjBfltXcylnasFoazd5do/f/9uiX0PmMep05IIb
   sH1lF52VwQiHC4BOgljTr7C4im2XBUZJcPoEiJMK+wE5sjVM58yB2MR34
   dsnOzeyZbDsI4Y60JkEGhI+YMIjP219CQxopREorAgdBoH9T7saDY0fc+
   A==;
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="297100399"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2021 09:16:08 +0800
IronPort-SDR: pk6nvTst+hmEnRr6DCVEhP8U9e6WXRiqx2XPmIQFjxAiCsDWXkx4C5okfeJsSEOnnjJB3OxCId
 ZcVjAIrQ9+9qs0WBmaQFodGVT4SohUI1tfeKuSTZNWeSr68vM2xOFeiGFj+4F+LUpukFyzZNk8
 D1OI8sQ+7e4esv1LHYNJ/6fe1HQoq5XtEEXxoYKquHkKNhfSutXqDeBDDWjKuje6c3om0ToRl5
 PX9A7ok/E2dZwi3z8JeM/8kn8M2Sb+xOMwriocC/q6Is9E+GnW0VZ89/RZiWaq0mQTzMxbmFjj
 Bcm6rLzXzbvO7k+fjSYYfP8H
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 16:49:46 -0800
IronPort-SDR: xYULkgMqce9VKlnj3x5Cw4t1ASvjOuT5BXLsjCz3sHhONxYu78+Y1Je+QbxNmFVLXk+3V0b7kd
 4IW9OK1ajxMtYZIWFhG60I5v/7QHj+U2Gnm2ZjPDuGKdJxfZi/e6KFtPVPDoRovfLIvQpkVYbX
 VGcyHeoMnXxczyOxWDxvg4SGkznw1FhIP9EqQaT8OL4GGZy/SuK7ffB8FWaY3X/mEj3B1od5Qa
 odhQUyX68bm6g8RzVrUlpRmhm4XKEdAnRWgyJrBtmW6iRsCbGG1a40DbQTd4fMknTTpqCiByVE
 FKo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:16:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HqP1N2bZ6z1RtVt
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 17:16:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636593367; x=1639185368; bh=yxG7AS0Kke4Fc/lJ+UMGhKlUwWn7XHRNaQX
        mVig4wHY=; b=CqQAfxoewqQXQjMwQDGRb6Bagy3O+xvo3YiVaXBEi/kfcFzn0sZ
        QUTiBpvegsAljn0utEnNBF//ev75pjLJrP1dG7hC7KBwry2NiIiftIzLIcfCXTW0
        r/SrKh2qH/3yMWLg8L5I6O81gWzARTZQMyYewyaUhoWf6YUQuoa9MUqAY2/OC78O
        UcvRplwyuQCh1OdYs67lxxNE0sIh+dJ6FflyI7OJmk8SG5Rsb/oW7Q4zVEAAEUmk
        jOsvMBt7XkLt23vQHZT0xAW67xz8ZeqdvjAkYmJF/WfUBBDeM/R3bXqo9LfUc9/c
        g02VqMsXmmSogwg5YCTGL8cFWguVMFw++/Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kau0jEIfvrLP for <linux-block@vger.kernel.org>;
        Wed, 10 Nov 2021 17:16:07 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HqP1M1TVCz1RtVl;
        Wed, 10 Nov 2021 17:16:06 -0800 (PST)
Message-ID: <b5eb5ffd-574b-3911-660e-89c576ea2bc1@opensource.wdc.com>
Date:   Thu, 11 Nov 2021 10:16:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: Unreliable disk detection order in 5.x
Content-Language: en-US
To:     Simon Kirby <sim@hostway.ca>, Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20211105064623.GD32560@hostway.ca>
 <9c14628f-4d23-dedf-3cdc-4b4266d5a694@opensource.wdc.com>
 <20211107022410.GA6530@hostway.ca>
 <ce4f925f-cbf9-9bbb-4bde-dd57059e3c84@acm.org>
 <20211111010106.GA27431@hostway.ca>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211111010106.GA27431@hostway.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/11 10:01, Simon Kirby wrote:
> On Sun, Nov 07, 2021 at 11:51:45AM -0800, Bart Van Assche wrote:
> 
>> On 11/6/21 19:24, Simon Kirby wrote:
>>> This occurs regardless of the CONFIG_SCSI_SCAN_ASYNC setting, and
>>> also with scsi_mod.scan=sync on vendor kernels. All of these disks
>>> are coming from the same driver and card.
>>>
>>> I understand that using UUIDs, by-id, etc., is an option to work
>>> around this, but then we would have to push IDs for disks in every
>>> server to our configuration management. It does not seem that this
>>> change is really intentional.
>>
>> SCSI disk detection is asynchronous on purpose since a long time. The most
>> recent commit I know of that changed SCSI disk scanning
>> behavior is commit f049cf1a7b67 ("scsi: sd: Rely on the driver core for
>> asynchronous probing").
>>
>> Please use one of the /dev/disk/by-*/* identifiers as Damien requested.
> 
> Hi Bart,
> 
> So, we're using DRBD on top of these, which means by-uuid is not
> available; we can use only by-id and by-path. by-id is dependent on disk
> models and serial numbers, and by-path is dependent on PCI bus details.
> Both are going to be a good deal more work to maintain, since they're
> both not just a simple enumeration.
> 
> I did try 5.14.17 with f049cf1a7b67 (and a065c0faacb1) reverted, and it
> does indeed restore the behaviour where sd* order appears to be reliable.
> Scan time (time until systemd starts) is within 4ms across 3 boots with
> and without the revert, but this is just our particular case.
> 
> I don't fully understand the scan process here, but I can understand the
> challenges in trying to parallelize it and still end up with a consistent
> enumerated list.

Even without parallel disk scan on boot to ensure a consistent naming of drives
from some port or LUN order, any run-time event that cause a drive to "go away"
and come back (e.g. topology change event) can result in the drive name
changing. The order itself depends on the LLD code too. A driver change can
result in a different probe order, so in different names. Same if say you
create/delete LUNs on a RAID system: when doing it, you will get some drive
names, but after a reboot & scan, the LUNs may be presented with different
names. /dev/sdX names are simply not reliable. For consistent, reliable, drive
configurations, applications must use the /dev/disk/by-*/* IDs.

> 
> I guess you would agree that removing sd* entirely would not be an option
> because they've existed forever historically, but at the same time, the
> only time they really "work" now are as symlink targets for by-*, and in
> the case where only one disk exists at boot time. Do I have this right?
> 
> Simon-
> 


-- 
Damien Le Moal
Western Digital Research
