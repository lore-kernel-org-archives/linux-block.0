Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36693 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdCQUjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 16:39:23 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>, "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v1 3/3] blk-mq: start to freeze queue just after setting
 dying
Date: Fri, 17 Mar 2017 20:36:58 +0000
Message-ID: <1489783004.2826.13.camel@sandisk.com>
References: <20170317095711.5819-1-tom.leiming@gmail.com>
         <20170317095711.5819-4-tom.leiming@gmail.com>
         <1489771915.2826.4.camel@sandisk.com>
         <CACVXFVPF0Sx5HyU+xw0MyghYMWifZ0SDH0YCtM-jrhieOJOJGg@mail.gmail.com>
In-Reply-To: <CACVXFVPF0Sx5HyU+xw0MyghYMWifZ0SDH0YCtM-jrhieOJOJGg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-03-18 at 02:32 +0800, Ming Lei wrote:
> On Sat, Mar 18, 2017 at 1:32 AM, Bart Van Assche wrote:
> > +       /*
> > +        * Avoid that the updates of the queue flags and q_usage_counte=
r
> > +        * are reordered.
> > +        */
> > +       smp_wmb();
>=20
> atomic_inc_return() in blk_mq_freeze_queue_start() does imply a
> barrier(smp_mb()).

Hello Ming,

It's probably a good idea to mention that in a comment. The implementation
of blk_mq_freeze_queue_start() namely could be changed in the future such
that it uses another atomic operation that doesn't implicitly perform smp_m=
b().

Thanks,

Bart.=
