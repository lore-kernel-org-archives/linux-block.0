Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33406 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdGQAPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Jul 2017 20:15:41 -0400
MIME-Version: 1.0
In-Reply-To: <72dd4c34-f780-e20f-f604-3edf018b138a@suse.de>
References: <20170714081444.32645-1-ming.lei@redhat.com> <20170714081444.32645-4-ming.lei@redhat.com>
 <72dd4c34-f780-e20f-f604-3edf018b138a@suse.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 17 Jul 2017 08:15:39 +0800
Message-ID: <CACVXFVPyXMqhSkKsEyf_Onhg61W35ACxzMWbdD64Kfo7qQt1Pw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] md: raid1-10: move raid1/raid10 common code into raid1-10.c
To: Coly Li <colyli@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Shaohua Li <shli@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jul 16, 2017 at 1:14 PM, Coly Li <colyli@suse.de> wrote:
> On 2017/7/14 =E4=B8=8B=E5=8D=884:14, Ming Lei wrote:
>> No function change, just move 'struct resync_pages' and related
>> helpers into raid1-10.c
>
> Please give me a hint, I don't find where raid1-10.c is ....

It is introduced in this patch, :-)


--=20
Ming Lei
