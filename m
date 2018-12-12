Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DDC6783B
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB7620851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGVCIyeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB7620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLLAiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:38:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36901 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLAiz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 19:38:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so15938156wru.4
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 16:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMIrf9w/Zyf58ey8muzO9zk7jTOiMcJLzQLehgUHhB8=;
        b=FGVCIyeTGpUKdROz9ll3Abgc03ELKDX9ljJUCetfEZMsDecAmqgtUZl3gcwcWtU11N
         Hzbk3bM7mb+rVTRmI+imE06K49wZXI8nP6WNcOigSb++1VIbNfBA7tgYDlGT6/cGoVR+
         7Uf9ub5kF2QxRRtwmLJmjlsNDPFuAkabSPShZUObnssCDN1FOXLtacxrU80PfnnhTo1K
         WGNVwKbx7zkWrKOIiF6pkH7bIT4nENQTI8UhjrQtbxa8rD71lExh52VKrCI7iPrJkqyR
         jqP4iupE6/+Uegz5j695bNUwb49ngTPqNAtlpb1/Z0brwt7NgeFnTT0xBDa7NZKLvvGi
         ENww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMIrf9w/Zyf58ey8muzO9zk7jTOiMcJLzQLehgUHhB8=;
        b=uNPjeYrRzm56EaO5dfEi4oYwxrmjuwVLP/16CWgUkgj574XXKd1XwGZp5MHDwEBbK8
         xkgnDUQj87uk4nhyWZsmc1PqokRl3LlVMZFtwJvDalxVFfJ6qbZ7sDepatoZfDo1Omwg
         Olpq+pyjUBsjYTfdhdlvKgO1gd3T6OZnh6WnuRF0KISMUYC/rV55Ie+dxjP9FkwAsI0p
         WOLKoRaj32YEu4ffpeCFhHmS2++S7Zfnsba/0f70Bx/DszM6bE+vPDKVqkvEmoarKryC
         YLFa1qrq/vKrU4PaDUa7atQ0tP2I12KZmJVC07jN2EX0Hmc91Qkth43WGIV2vWdhgKwa
         G3MQ==
X-Gm-Message-State: AA+aEWYRjyzHHHRIyHbEQYN4z9OttEGgvb5+VugQ5DlqCgVZJauB4xeh
        YbuwHUgfGSbEK2/tedAMWGatv+Doyr5cVp/J6Ws=
X-Google-Smtp-Source: AFSGD/XPXIe7TrygRczjtGvGL370a2sMJAmbt6TBVSVBLZan9cMlL3+jsiuoffbfOeNq7z3OhRJvSTxNNXmVq9MJ/PY=
X-Received: by 2002:adf:9786:: with SMTP id s6mr15277719wrb.283.1544575133178;
 Tue, 11 Dec 2018 16:38:53 -0800 (PST)
MIME-Version: 1.0
References: <1544569107.185366.391.camel@acm.org> <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
 <CACVXFVObwybJ1hmekS_bJ05zrOawoG33MQDVda+W1ATa+SqNCw@mail.gmail.com> <20181212002759.GC20445@redhat.com>
In-Reply-To: <20181212002759.GC20445@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 12 Dec 2018 08:38:41 +0800
Message-ID: <CACVXFVP_xGwwEr4xs64z69tkA8Wm20VVew9axcJRpqZ_-a3DNA@mail.gmail.com>
Subject: Re: for-next hangs on test srp/012
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000248240057cc86c62"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000248240057cc86c62
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 12, 2018 at 8:28 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Tue, Dec 11 2018 at  7:19pm -0500,
> Ming Lei <tom.leiming@gmail.com> wrote:
>
> > On Wed, Dec 12, 2018 at 8:04 AM Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > On 12/11/18 3:58 PM, Bart Van Assche wrote:
> > > > Hi Jens,
> > > >
> > > > If I run the following subset of blktests:
> > > >
> > > >   while :; do ./check -q srp && ./check -q nvmeof-mp; done
> > > >
> > > > against today's for-next branch (commit dd2bf2df85a7) then after some
> > > > time the following hang is reported:
> > > >
> > > > INFO: task fio:14869 blocked for more than 120 seconds.
> > > >       Not tainted 4.20.0-rc6-dbg+ #1
> > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > fio             D25272 14869  14195 0x00000000
> > > > Call Trace:
> > > >  __schedule+0x401/0xe50
> > > >  schedule+0x4e/0xd0
> > > >  io_schedule+0x21/0x50
> > > >  blk_mq_get_tag+0x46d/0x640
> > > >  blk_mq_get_request+0x7c0/0xa00
> > > >  blk_mq_make_request+0x241/0xa70
> > > >  generic_make_request+0x411/0x950
> > > >  submit_bio+0x9b/0x250
> > > >  blkdev_direct_IO+0x7fb/0x870
> > > >  generic_file_direct_write+0x119/0x210
> > > >  __generic_file_write_iter+0x11c/0x280
> > > >  blkdev_write_iter+0x13c/0x220
> > > >  aio_write+0x204/0x310
> > > >  io_submit_one+0x9c6/0xe70
> > > >  __x64_sys_io_submit+0x115/0x340
> > > >  do_syscall_64+0x71/0x210
> > > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > >
> > > > When that hang occurs my list-pending-block-requests script does not show
> > > > any pending requests:
> > > >
> > > > # list-pending-block-requests
> > > > dm-0
> > > > loop0
> > > > loop1
> > > > loop2
> > > > loop3
> > > > loop4
> > > > loop5
> > > > loop6
> > > > loop7
> > > > nullb0
> > > > nullb1
> > > > sda
> > > > sdb
> > > > sdc
> > > > sdd
> > > > vda
> > > > vdb
> > > >
> > > > Enabling fail_if_no_path mode did not resolve the hang so I don't think
> > > > that the root cause is in any of the dm drivers used in this test:
> > > >
> > > > # dmsetup ls | while read dm rest; do dmsetup message $dm 0 fail_if_no_path; done; dmsetup remove_all; dmsetup table
> > > > 360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1
> > > >
> > > > The same test passes against kernel v4.20-rc6.
> > >
> > > What device is this being run on?
> >
> > I saw this issue on usb storage too.
> >
> > Seems it is introduced by commit ea86ea2cdced ("sbitmap: ammortize cost of
> > clearing bits"). When the IO hang happens, .cleared is 2, and .busy is 0 on
> > the sched_tag's sbitmap queue.
>
> You saw this running the same tests as Bart?

Not the srp test as done by Bart, I just run 'parted' test on usb storage disk,
see the attached test script.

Mostly it can be triggered in one run, sometimes it needs more.

Thanks
Ming Lei

--000000000000248240057cc86c62
Content-Type: application/octet-stream; name=parted
Content-Disposition: attachment; filename=parted
Content-Transfer-Encoding: base64
Content-ID: <f_jpkg39i40>
X-Attachment-Id: f_jpkg39i40

IyEvYmluL2Jhc2gKCnBhcnRlZF9kaXNrKCkKewoJRElTSz0kMQoJQ05UPSQyCgoJREVWX1NJWkU9
YGJsb2NrZGV2IC0tZ2V0c3ogJERJU0tgCglERVZfU0laRT1gZXhwciAke0RFVl9TSVpFfSAvIDIw
NDhgTUIKCglERVZfTkFNRT1gYmFzZW5hbWUgJERJU0tgCglRX1BBVEg9L3N5cy9ibG9jay8kREVW
X05BTUUvcXVldWUKCglpZiBbIC1mICRRX1BBVEgvLi4vZGV2aWNlL3F1ZXVlX2RlcHRoIF07IHRo
ZW4KCQlNWV9TQ1NJX1FEPWBjYXQgJFFfUEFUSC8uLi9kZXZpY2UvcXVldWVfZGVwdGhgCgllbHNl
CgkJTVlfU0NTSV9RRD0iTi9BIgoJZmkKCU1RX0lPU0NIRURTPWBzZWQgJ3MvW11bXS8vZycgJFFf
UEFUSC9zY2hlZHVsZXJgCgoJZm9yIFNDSEVEIGluICRNUV9JT1NDSEVEUzsgZG8KCQllY2hvICRT
Q0hFRCA+ICRRX1BBVEgvc2NoZWR1bGVyCgkJTVlfU0NIRUQ9YGNhdCAkUV9QQVRIL3NjaGVkdWxl
ciB8IHNlZCAtbiAncy8uKlxbXCguKlwpXF0uKi9cMS9wJ2AKCQllY2hvICJEZXYuICRERVZfTkFN
RSwgU0NIRUQ6ICRNWV9TQ0hFRCwgU0NTSSBRRDogJE1ZX1NDU0lfUUQiCgkJY291bnQ9MAoJCXdp
cGVmcyAtYSAkRElTSyAmJiBibG9ja2RldiAtLXJlcmVhZHB0ICRESVNLCgkJd2hpbGUgWyAkY291
bnQgLWx0ICRDTlQgXTsgZG8KCQkJcGFydGVkIC1tIC1zICRESVNLIG1rbGFiZWwgbXNkb3MgJiYK
CQkJCQlwYXJ0ZWQgLW0gLXMgLWEgbm9uZSAkRElTSyBta3BhcnQgcHJpbWFyeSAwTUIgMzJNQiAm
JgoJCQkJCXBhcnRlZCAtbSAtcyAtYSBub25lICRESVNLIG1rcGFydCBwcmltYXJ5IDMyTUIgJERF
Vl9TSVpFICYmCgkJCQkJcGFydGVkIC1zICRESVNLIHAKCQkJbGV0IGNvdW50KysKCQkJaWYgISAo
KCBjb3VudCAlIDEwICkpOyB0aGVuCgkJCQllY2hvICRjb3VudAoJCQlmaQoJCWRvbmUKCWRvbmUK
fQoKRElTSz0kMQpDTlQ9JDIKcGFydGVkX2Rpc2sgJERJU0sgJENOVAo=
--000000000000248240057cc86c62--
