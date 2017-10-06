Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:51876 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbdJFJUE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 05:20:04 -0400
Received: by mail-qt0-f176.google.com with SMTP id q4so30244166qtq.8
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 02:20:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cb6db7c0-eaf7-f4a8-5584-8ce512575d74@coly.li>
References: <1506497553-12552-1-git-send-email-tang.junhui@zte.com.cn>
 <CAJ+L6qe9XjPOw=6NpWzZhw-PLC5EXhstOrPaapbqvDcD0+_7QA@mail.gmail.com>
 <CAJ+L6qcU+Db5TP1Q2J-V8angdzeW9DFGwc7KQqc4di9CSxusLg@mail.gmail.com>
 <CAJ+L6qdu4OSRh7Qdkk-5XBgd4W_N29Y6-wVLf-jFAMKEhQrTbQ@mail.gmail.com>
 <CAJ+L6qcyq-E4MrWNfB9kGA8DMD_U1HMxJii-=-qPfv0LeRL45w@mail.gmail.com>
 <CAJ+L6qdc8YqO5B3Cv0h4QQ+4P06FbtsT10Jqt5=Fx8iRh1UGwQ@mail.gmail.com>
 <96f34768-2b02-7849-c034-e1bb83b0fa0d@coly.li> <CAJ+L6qdTB6DyhD8UwHaVtN-THXwanBXrQK3EvmvLhuoXgYyzrA@mail.gmail.com>
 <05c1aa86-5fc8-f330-5cd1-46f9ba7cd3e0@coly.li> <CAJ+L6qfTDkgrLEUSRX2Pv2qvB7Ns=Hb3nBVz0SDoDn_m9RC8hg@mail.gmail.com>
 <2c39cd9c-34bd-5982-9fd7-ceb61305c13d@coly.li> <CAJ+L6qe7C=FyPFya8y0HV8SCc7VSEEuUApcqEUnouVDUByfZ5w@mail.gmail.com>
 <6a2052da-6b52-9c06-b85e-e3ea29e3f8e8@coly.li> <CAJ+L6qdqQn4tpFdkPZ-zhxss9O8axBEarMBJA5X6f9i+K8SLGg@mail.gmail.com>
 <CAJ+L6qe8rwbtO6tR-QNQBUApbeGQ9NGD=P9t5gtN9j0kzacJEQ@mail.gmail.com> <cb6db7c0-eaf7-f4a8-5584-8ce512575d74@coly.li>
From: Michael Lyle <mlyle@lyle.org>
Date: Fri, 6 Oct 2017 02:20:02 -0700
Message-ID: <CAJ+L6qdG70ExM7cnwYFLmCDBXY8SBErLhnMNeFVscXYemb_1SQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] bcache: writeback: collapse contiguous IO better
To: Coly Li <i@coly.li>
Cc: Junhui Tang <tang.junhui@zte.com.cn>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Coly--

I did not say the result from the changes will be random.

I said the result from your test will be random, because where the
writeback position is making non-contiguous holes in the data is
nondeterministic-- it depends where it is on the disk at the instant
that writeback begins.  There is a high degree of dispersion in the
test scenario you are running that is likely to exceed the differences
from my patch.

Mike
