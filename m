Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34965 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbdCQAHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2017 20:07:44 -0400
MIME-Version: 1.0
In-Reply-To: <1489700141.2574.16.camel@sandisk.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
 <1489064578-17305-3-git-send-email-tom.leiming@gmail.com> <1489536441.2676.21.camel@sandisk.com>
 <20170315121851.GA15807@ming.t460p> <20170315124024.GA16549@ming.t460p>
 <1489592177.2660.1.camel@sandisk.com> <20170315162158.GA18768@ming.t460p>
 <1489613678.2660.9.camel@sandisk.com> <20170316000747.GA19948@ming.t460p> <1489700141.2574.16.camel@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 17 Mar 2017 08:07:42 +0800
Message-ID: <CACVXFVNHA4Dh-rx8VsVnwaY4iZJY2tucKF7V-WcNNa4=F5twfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in timeout handler
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 17, 2017 at 5:35 AM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Thu, 2017-03-16 at 08:07 +0800, Ming Lei wrote:
>> > * Check whether REQ_ATOM_STARTED has been set.
>> > * Check whether REQ_ATOM_COMPLETE has not yet been set.
>> > * If both conditions have been met, set REQ_ATOM_COMPLETE.
>> >
>> > I don't think there is another solution than using a single state variable to
>> > represent the REQ_ATOM_STARTED and REQ_ATOM_COMPLETE states instead of two
>> > independent bits. How about the patch below?
>>
>> I would review it if you can confirm me that it is a real issue, :-)
>
> Hello Ming,
>
> I was chasing a v4.11 regression in the SCSI stack. Since my tests of today
> revealed that it's probably not a block layer issue, let's proceed with your
> patch.

Yeah, it shouldn't have been related with blk-mq timeout handler which
isn't changed much
recently, and thanks for your review!



Thanks,
Ming Lei
