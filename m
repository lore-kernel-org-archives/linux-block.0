Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:49197 "EHLO
	mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751973AbcFGPMC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 7 Jun 2016 11:12:02 -0400
Received: from pps.filterd (m0075030.ppops.net [127.0.0.1])
	by mx0b-00003501.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u57F9ic5004223
	for <linux-block@vger.kernel.org>; Tue, 7 Jun 2016 11:11:59 -0400
Received: from mail-qk0-f198.google.com (mail-qk0-f198.google.com [209.85.220.198])
	by mx0b-00003501.pphosted.com with ESMTP id 23e0nvg0as-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 07 Jun 2016 11:11:59 -0400
Received: by mail-qk0-f198.google.com with SMTP id t65so163830309qkh.3
        for <linux-block@vger.kernel.org>; Tue, 07 Jun 2016 08:11:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160607114039.urf62b6gqgxsrxuv@ws.net.home>
References: <1465229095-27651-1-git-send-email-shaun@tancheff.com>
 <20160607110534.lyhrwy2drpe6wbz7@ws.net.home> <20160607114039.urf62b6gqgxsrxuv@ws.net.home>
From: Shaun Tancheff <shaun.tancheff@seagate.com>
Date: Tue, 7 Jun 2016 10:11:39 -0500
Message-ID: <CAJVOszAGyCQC6-GF-WoL01DTBHduORH8+a0sKwFy7ZhTn0wswQ@mail.gmail.com>
Subject: Re: [PATCH] Zoned block device support
To: Karel Zak <kzak@redhat.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, util-linux@vger.kernel.org,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 7, 2016 at 6:40 AM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jun 07, 2016 at 01:05:34PM +0200, Karel Zak wrote:
>> On Mon, Jun 06, 2016 at 11:04:54AM -0500, Shaun Tancheff wrote:
>> > ZBC/ZAC compliant devices such as Host Aware drives are now available.
>> >
>> > This patch follows the pattern of blkdiscard to and zoned device
>> > commands Open, Close and Reset as well as Report zones.
>>
>> What is difference between zone "reset" and blkdiscard(8)?
>
> Well, I read something more about SMR, it makes more sense now :-)
>
> Maybe you can explain all the zones concept in the man page to make it
> more usable for end-users.

Yes that would be good. I will update the man pages.

Thanks!
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  https://urldefense.proofpoint.com/v2/url?u=http-3A__karelzak.blogspot.com&d=CwIBAg&c=IGDlg0lD0b-nebmJJ0Kp8A&r=Wg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=RU2eUqouhMtoA5UFmcTyuV7sBBQKdrVNjwaWvP8bo7I&s=wAwv18Fm_nJYMAZ5ARznRUfvTkAX_YZEVuAu2O0w9OI&e=
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=CwIBAg&c=IGDlg0lD0b-nebmJJ0Kp8A&r=Wg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=RU2eUqouhMtoA5UFmcTyuV7sBBQKdrVNjwaWvP8bo7I&s=rLqg3KxoFebUGJrz0CS4wxG0BgLiF2wfqHu7U41opRI&e=



-- 
Shaun Tancheff
