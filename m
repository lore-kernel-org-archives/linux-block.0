Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:54802 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754773AbdKAQ4B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2017 12:56:01 -0400
Received: by mail-io0-f171.google.com with SMTP id e89so7445236ioi.11
        for <linux-block@vger.kernel.org>; Wed, 01 Nov 2017 09:56:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509395628.27259.19.camel@wdc.com>
References: <20171027044330.11921-1-ming.lei@redhat.com> <1509079996.3244.3.camel@wdc.com>
 <20171027053834.GA12858@ming.t460p> <CAJrWOzD0LoFhKhFf-BrCtWipVEteT3uUqUc30_qr8E8wNeESGg@mail.gmail.com>
 <1509395628.27259.19.camel@wdc.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Wed, 1 Nov 2017 17:55:40 +0100
Message-ID: <CAJrWOzDiNTMUttm9WixXD4M=Lv4P1h312r9QBM0N9Y7i_Nr+8g@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 30, 2017 at 9:33 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Fri, 2017-10-27 at 19:55 +0200, Roman Penyaev wrote:
>> That's just a bug in code, not a in issue with restarts, which can be fixed
>> if we put hctx which are needed to be restarted in percpu lists and avoid
>> long loops and contentions.
>
> Hello Roman,
>
> Have you noticed that recently .get_budget() and .put_budget() callbacks have
> been added into struct blk_mq_ops? If block drivers that support shared tags
> implement these callback functions properly then maybe busy conditions become
> infrequent enough to use a single "hctx busy" list per tag set instead of
> per-cpu "hctx busy" lists.

Hi Bart,

No, not yet.  Thanks, good tip.

--
Roman
