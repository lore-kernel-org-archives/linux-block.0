Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B47BCA9ECF
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CF6218AC
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LXR1GGLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfKAR4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:56:34 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43434 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfKAR4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 13:56:33 -0400
Received: by mail-il1-f196.google.com with SMTP id j2so7244621ilc.10
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2019 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fVMecHB4iqy/JcrkafiqEnLMlJZ7+7jzZA1mGmL5dRI=;
        b=LXR1GGLkYQybIQFAxI5i1hnPTzEMnuLx819TYZ3yoXl9FpEQvAxhzKlssv/rYdGLKf
         8LzM8bOCBl2TtsMukEZtl2Y0MWbZMcXWU2lTGNBc1iU2IVmugt0L8LjylC9Vcvg110S7
         QphjQ+6wsclxIpnuZ4iCDK39C6qXXHEP7BdFr0X3de5Zpy0t4b1IQZv9M8IRjJNZ13n9
         5Suf46JlO+qZq8x3RAMegJn3v1cdTihpkx4uWy2oJwuU5jQvhv5CJ15YJz+ByPVKKsub
         5yHLKuNrfWutqMmU3j/NDTnV+aWSQuABWA9kZc1wSGTEp7+qn5RaxChLi/4Zs3lMmyLh
         ueNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fVMecHB4iqy/JcrkafiqEnLMlJZ7+7jzZA1mGmL5dRI=;
        b=d52kbr01b0ej0BjHnGFkXvvTdRCzqpJ7fgNeufXVZqve2KS+G+i3R3h11w5dRKxwiN
         VB16Buyp7tiOIuhjUgKtkSDuTsxfG2Jml1NRk1JFXj1Yrc1BvHNntNE0QXeGePwEIeR8
         kjYTqLi73fd7lr6iwKniWxyhiKoHgHusriwK9xelQIUTZV+iv+sAt8HN1djkdoMrtCup
         hQlHeEzJFbCShDc0vg0IkYUMlWkyrTP1wFZMDwVlkUUcrI3I9s8h+AKkNY/j3ze8HRBn
         sXIL9LNebrhr2kNIEozlpZnyyfDtRoyJcGUMZGIFm7PIhuYF4ZGDP5j5KWWquc1FIc/t
         yAuQ==
X-Gm-Message-State: APjAAAWIVA2FR5sWUFzgbItaIT91gkZUiPMgCbCfn6SGIFvMdWgKBb6R
        wg1juf6FiZStavIcH5enlq0lmQ==
X-Google-Smtp-Source: APXvYqwAhGOHpfrylwdtk9bVK77UdVTEj4lT1jPVHRKsDs+bvH4Fv1WxHT89f+9cyVKHL3NyOnvx+w==
X-Received: by 2002:a92:650d:: with SMTP id z13mr13087195ilb.18.1572630991510;
        Fri, 01 Nov 2019 10:56:31 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d27sm1092561ill.64.2019.11.01.10.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 10:56:30 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel paging request in io_wq_cancel_all
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, mchehab+samsung@kernel.org,
        Ingo Molnar <mingo@redhat.com>, patrick.bellasi@arm.com,
        Richard Guy Briggs <rgb@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <00000000000069801e05961be5fb@google.com>
 <0e2bc2bf-2a7a-73c5-03e2-9d08f89f0ffa@kernel.dk>
 <CACT4Y+asiAtMVmA2QiNzTJC8OsX2NDXB7Dmj+v-Uy0tG5jpeFw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fe298b7-4bc9-58e7-4173-63e3cbcbef25@kernel.dk>
Date:   Fri, 1 Nov 2019 11:56:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+asiAtMVmA2QiNzTJC8OsX2NDXB7Dmj+v-Uy0tG5jpeFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/19 11:50 AM, Dmitry Vyukov wrote:
> On Wed, Oct 30, 2019 at 3:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/30/19 1:44 AM, syzbot wrote:
>>> syzbot has bisected this bug to:
>>>
>>> commit ef0524d3654628ead811f328af0a4a2953a8310f
>>> Author: Jens Axboe <axboe@kernel.dk>
>>> Date:   Thu Oct 24 13:25:42 2019 +0000
>>>
>>>        io_uring: replace workqueue usage with io-wq
>>>
>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16acf5d0e00000
>>> start commit:   c57cf383 Add linux-next specific files for 20191029
>>> git tree:       linux-next
>>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15acf5d0e00000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=11acf5d0e00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000
>>>
>>> Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com
>>> Fixes: ef0524d36546 ("io_uring: replace workqueue usage with io-wq")
>>
>> Good catch, it's a case of NULL vs ERR_PTR() confusion. I'll fold in
>> the below fix.
> 
> Hi Jens,
> 
> Please either add the syzbot tag to commit, or close manually with
> "#syz fix" (though requires waiting until the fixed commit is in
> linux-next).
> See https://goo.gl/tpsmEJ#rebuilt-treesamended-patches for details.
> Otherwise, the bug will be considered open and will waste time of
> humans looking at open bugs and prevent syzbot from reporting new bugs
> in io_uring.

It's queued up since two days ago:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=975c99a570967dd48e917dd7853867fee3febabd

and should have the right attributions, so hopefully it'll catch up
eventually.

-- 
Jens Axboe

