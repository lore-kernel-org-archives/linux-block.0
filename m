Return-Path: <linux-block-owner@vger.kernel.org>
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:19697 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeBWE3h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 23:29:37 -0500
Content-type: text/plain; charset=gb2312
MIME-version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] blk-throttle: avoid multiple counting for same bio
From: Chengguang Xu <cgxu519@icloud.com>
In-reply-to: <ddbcd815-a347-a465-f3e8-2537307110cf@gmail.com>
Date: Fri, 23 Feb 2018 12:29:25 +0800
Cc: Tejun Heo <tj@kernel.org>, axboe@fb.com,
        Shaohua Li <shli@kernel.org>, vgoyal@redhat.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        xuejiufei <jiufei.xue@linux.alibaba.com>
Message-id: <7E596018-7D00-4537-B717-697FE401DD55@icloud.com>
References: <1518504350-139546-1-git-send-email-cgxu519@icloud.com>
 <20180213144314.GP695913@devbig577.frc2.facebook.com>
 <E42EF2AF-710E-4783-BFFE-D77502B4E04C@icloud.com>
 <ddbcd815-a347-a465-f3e8-2537307110cf@gmail.com>
To: Joseph Qi <jiangqi903@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Joseph,

Thanks for quick reply, I didn=A1=AFt notice that patch before.


Thanks,
Chengguang.


> =D4=DA 2018=C4=EA2=D4=C223=C8=D5=A3=AC=C9=CF=CE=E711:55=A3=ACJoseph Qi =
<jiangqi903@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
>=20
>=20
> On 18/2/23 11:33, Chengguang Xu wrote:
>> Hi Tejun,
>>=20
>> Sorry for delayed reply, I was on vacation last week.
>>=20
>> The problem still exists in current code of 4.16.0-rc2,=20
>> detail test information is below, if further info is needed please =
let me know.
>>=20
>> Thanks.
>>=20
> That's true, the issue Shaohua has fixed is double charge, but double
> stat issue still exists.
>=20
> Jiufei has posted a fix, which has already been tested by Bo Liu:
> [PATCH RESEND] blk-throttle: avoid double counted
> https://www.mail-archive.com/linux-block@vger.kernel.org/msg18516.html
>=20
> Thanks,
> Joseph
> --
> To unsubscribe from this list: send the line "unsubscribe cgroups" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
