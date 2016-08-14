Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34000 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbcHNJzx (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sun, 14 Aug 2016 05:55:53 -0400
MIME-Version: 1.0
In-Reply-To: <CAGnHSE=yBrBCbyKMNKBpZHRX7YKR-TV-s5YybvTKW18_gcrAbw@mail.gmail.com>
References: <60518e90d462d4cbb1c528914eac64e2fe124717.1471011949.git.tom.ty89@gmail.com>
 <974f3a0aa9e82caf067353fd7d7119c07d7e98c1.1471011949.git.tom.ty89@gmail.com>
 <yq11t1tmzxb.fsf@sermon.lab.mkp.net> <CAGnHSE=yBrBCbyKMNKBpZHRX7YKR-TV-s5YybvTKW18_gcrAbw@mail.gmail.com>
From: Tom Yan <tom.ty89@gmail.com>
Date: Sun, 14 Aug 2016 17:40:41 +0800
Message-ID: <CAGnHSEmnj5Bf5CJom=2e9VurxRyFwNBbwmgg1wpM8h2NvQkN-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sd: check BLK_DEF_MAX_SECTORS against max_dev_sectors
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 14 August 2016 at 17:00, Tom Yan <tom.ty89@gmail.com> wrote:
>
> That won't really work. min_t() would, though the line is gonna be a
> bit long; not sure if I can/should simply cast the type (unsigned int)
> to BLK_DEF_MAX_SECTORS. And which braces are you referring to?
>
Oh you mean the else-clause braces. Hmm I thought the coding style was
that if you needed braces in one clause, you should use braces for
others in the condition even if it consists of only one line of
statement. At least that is what I was told when I send patches for
libata.

So, should I use min_t() or just do a type casting in front to
BLK_DEF_MAX_SECTORS? Also do I need to break the line at a certain
point when it exceeds certain length?
