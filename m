Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38971 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750891AbeAURjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jan 2018 12:39:52 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: blk-mq hangs easily with LLVM+clang test suite
From: David Zarzycki <dave@znu.io>
In-Reply-To: <1516555064.3434.5.camel@wdc.com>
Date: Sun, 21 Jan 2018 12:39:48 -0500
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <964830FA-5F0F-49D3-8608-FBCAF7D60326@znu.io>
References: <83F7B94F-562A-44A5-92F9-939FE4FD5A99@znu.io>
 <1516555064.3434.5.camel@wdc.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

I can do [1] and [2] but I won=E2=80=99t be able to provide the command =
output because the hang is almost total. No new commands can run because =
the scheduler is hung. For example, see this backtrace:

http://znu.io/IMG_0362.jpg

Is there another approach I can use?

Dave

> On Jan 21, 2018, at 12:17, Bart Van Assche <Bart.VanAssche@wdc.com> =
wrote:
>=20
> On Sun, 2018-01-21 at 11:19 -0500, David Zarzycki wrote:
>> How can I help debug this further?
>=20
> Please apply patch [1] on top of Jens' for-next branch [2], reproduce =
the
> hang and provide the output of the following command:
>=20
> (cd /sys/kernel/debug/block && find . -type f -exec grep -aH . {} \;)
>=20
> Thanks,
>=20
> Bart.
>=20
> [1] [PATCH] blk-mq-debugfs: Also show requests that have not yet been =
started
> https://www.mail-archive.com/linux-block@vger.kernel.org/msg17313.html
> [2] http://git.kernel.dk/cgit/linux-block/log/?h=3Dfor-next
