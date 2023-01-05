Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D2EC3DA7D
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 17:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjAERwP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjAERwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 12:52:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6E3DBC6
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 09:52:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so2778440pjd.0
        for <linux-block@vger.kernel.org>; Thu, 05 Jan 2023 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn0mF4Rzt2xJGz/OjuUC/0FM9L+vJsdwZ8UojIiYWoI=;
        b=SxFG/ohYh8wv3Ao6a+M8yftbqKwAdlRUQC87v1SSWnm9U7SQkbTtLAMxlErTEckqYA
         W4AZL4kJZMOt+am1SvzT2PRd/TUHbEIUH7PI3b7YWPcK/hkMI3uzlOx5JEiHbHbU1imr
         HIxnWOk0eqxStXYOiIStxrt3j+7oaVfB1CKG4IiyxInOtZ+Th7YYnsi09fb4XvZQIpJw
         X8lW2L4O3oOWcDwPiqEaWRKyVmd31aj+QubYOQ5b3ebecSdvsGv7nRXcX5z2x8HoZkci
         Fu1+kRtrC6mmLc+cHuQyFMRFW+zga4u65veS/8HhQ5WBG+sWeq2c1KbY1c4GBrd3SU5s
         89xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn0mF4Rzt2xJGz/OjuUC/0FM9L+vJsdwZ8UojIiYWoI=;
        b=XSsmCSV0ES6OXU+AZQ+FlFWt7iSS92N+vRJDB3YLVceqHbLG28rvx0152eCsI4ryjR
         thq9YEBcvwCG0nIlZv3CoF6Mh7fWKCeHsuAw3Ha61NweeHcuBi3Jwa32vtl12jSO0A+W
         sMq2Nmnaic3GcNl/GDwPJv6oZR1aaxIOPjAg/1Dxy8o5uE1PL0hmgm70hxdYEE5K+mre
         jqrZHjUXjO+7/HKQXdr4cZKwDRGKB3ZokwaKrz2OV38vDGbFOPR8ZOmaSSzE7gXyG39T
         xl41swlcN1iFrdKpuOIjsMgkDmrjaZu/qAtxOKkn/bZaivHxaD1mzBbHopSyJXhfoL4K
         jNWA==
X-Gm-Message-State: AFqh2kqtLw33ouOPLGjUasXo+ylB+zkkssiqSO7M/NBCqEQZ8RO7P9v4
        O4OkjpSDlF8JOoWf2+ofGIk=
X-Google-Smtp-Source: AMrXdXvtL7T6TKp0VscS/YynVzMr8k7Bd12d4lE6bTB8wdTngvpNInt754vMu1mKrclqB2A14UKQsQ==
X-Received: by 2002:a17:903:1315:b0:192:ccfc:c178 with SMTP id iy21-20020a170903131500b00192ccfcc178mr15429207plb.52.1672941132058;
        Thu, 05 Jan 2023 09:52:12 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b00189a7fbfd44sm26262351plm.211.2023.01.05.09.52.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2023 09:52:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: Potential hang on ublk_ctrl_del_dev()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Y7ZA/ULE4hg3lkbY@T590>
Date:   Thu, 5 Jan 2023 09:52:00 -0800
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7B3A381-60CD-402D-8F81-D65E7D186215@gmail.com>
References: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
 <Y7URsuwxaAHFmn8S@T590> <20EBDD77-21AD-4C39-B1F2-E9A9954FA360@gmail.com>
 <Y7ZA/ULE4hg3lkbY@T590>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jan 4, 2023, at 7:16 PM, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Wed, Jan 04, 2023 at 10:13:05AM -0800, Nadav Amit wrote:
>>=20
>>=20
>>> On Jan 3, 2023, at 9:42 PM, Ming Lei <ming.lei@redhat.com> wrote:
>>>=20
>>> On Tue, Jan 03, 2023 at 01:47:37PM -0800, Nadav Amit wrote:
>>>> Hello Ming,
>>>>=20
>>>> I am trying the ublk and it seems very exciting.
>>>>=20
>>>> However, I encounter an issue when I remove a ublk device that is =
mounted or
>>>> in use.
>>>>=20
>>>> In ublk_ctrl_del_dev(), shouldn=E2=80=99t we *not* wait if =
ublk_idr_freed() is false?
>>>> It seems to me that it is saner to return -EBUSY in such a case and =
let
>>>> userspace deal with the results.
>>>>=20
>>>> For instance, if I run the following (using ubdsrv):
>>>>=20
>>>> $ mkfs.ext4 /dev/ram0
>>>> $ ./ublk add -t loop -f /dev/ram0
>>>> $ sudo mount /dev/ublkb0 tmp
>>>> $ sudo ./ublk del -a
>>>>=20
>>>> ublk_ctrl_del_dev() would not be done until the partition is =
unmounted, and you
>>>> can get a splat that is similar to the one below.
>>>=20
>>> The splat itself can be avoided easily by replace wait_event with
>>> wait_event_timeout() plus loop, but I guess you think the sync =
delete
>>> isn't good too?
>>=20
>> I don=E2=80=99t think the splat is the issue. The issue is the =
blocking behavior,
>> which is both unconditional and unbounded in time, and (worse) takes =
place
>> without relinquishing the locks. wait_event_timeout() is therefore =
not a
>> valid solution IMHO.
>>=20
>>>=20
>>>>=20
>>>> What do you say? Would you agree to change the behavior to return =
-EBUSY?
>>>=20
>>> It is designed in this way from beginning, and I believe it is just =
for
>>> the sake of simplicity, and one point is that the device number =
needs
>>> to be freed after 'ublk del' returns.
>>>=20
>>> But if it isn't friendly from user's viewpoint, we can change to =
return
>>> -EBUSY. One simple solution is to check if the ublk block device
>>> is opened before running any deletion action, if yes, stop to delete =
it
>>> and return -EBUSY; otherwise go ahead and stop & delete the pair of =
devices.
>>> And the userspace part(ublk utility) needs update too.
>>>=20
>>> However, -EBUSY isn't perfect too, cause user has to retry the =
delete
>>> command manually.
>>=20
>> I understand your considerations. My intuition is that just as umount
>> cannot be done while a file is opened and would return -EBUSY, so =
should
>> deleting the ublock while the ublk is in use.
>>=20
>> So as I see it, there are 2 possible options for proper deletion of =
ublk,
>> and actually both can be implemented and distinguished with a new =
flag
>> (UBLK_F_*):
>>=20
>> 1. Blocking - similar to the way it is done today, but (hopefully) =
without
>>   holding locks, and with using wait_event_interruptible() instead of
>>   wait_event() to allow interruption (and return EINTR if =
interrupted).
>>=20
>> 2. Best-effort - returning EBUSY if it cannot be removed.
>>=20
>> I can imagine use-cases for both, and it would also allow you not to
>> change ubdsrv if you choose so.
>>=20
>> Does it make sense?
>=20
> I prefer to the 1st approach:
>=20
> 1) the wait event is still one positive signal for user to cleanup the
> device use, since the correct step is to umount ublk disk before =
deleting
> the device.
>=20
> 2) the wait still can avoid the current context to reuse the device
> number
>=20
> 3) after switching to wait_event_interruptible(), we need to avoid
> double delete, and one flag of UB_STATE_DELETED can be used for =
failing
> new delete command.
>=20
> 4) IMO new flag(UBLK_F_*) isn't needed to distinguish this change
> with current behavior.
>=20
> Please let us know if you'd like to cook one patch for improving
> the delete handling.

I can take a stab on it, but only in about 2 weeks time.

>=20
> BTW, there could be another option, such as, 'ublk delete --no-wait' =
just
> run the remove and without waiting at all, but not sure if it is =
useful.
>=20

I considered the userspace ublk as one possible implementation. I am not
sure this affects the kernel interfaces that are needed.

