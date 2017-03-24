Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52167 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdCXSp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 14:45:29 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 2/4] block: add a read barrier in blk_queue_enter()
Date: Fri, 24 Mar 2017 18:45:19 +0000
Message-ID: <1490381059.3312.15.camel@sandisk.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
         <20170324123621.5227-3-tom.leiming@gmail.com>
         <1490376267.3312.1.camel@sandisk.com>
         <CACVXFVN7_PovXhKFofqf7N99Fq6RHEtFojHzwc6AN1oEpFLYxA@mail.gmail.com>
In-Reply-To: <CACVXFVN7_PovXhKFofqf7N99Fq6RHEtFojHzwc6AN1oEpFLYxA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-03-25 at 01:38 +0800, Ming Lei wrote:
> As I explained, the dying flag should only be mentioned after we change
> the code in blk_set_queue_dying().

Hello Ming,

If patches 2 and 4 would be combined into a single patch then it wouldn't
be necessary anymore to update the comment introduced in patch 2 in patch 4=
.
I think that would make this patch series easier to review.

Since the issues fixed by your patches are longstanding issues, have you
considered to add a "Cc: stable" tag?

Thanks,

Bart.=
