Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17976 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdE3PQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 11:16:27 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2 1/8] blk-mq: introduce blk_mq_unquiesce_queue
Date: Tue, 30 May 2017 15:09:36 +0000
Message-ID: <1496156976.2627.4.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <20170527142126.26079-2-ming.lei@redhat.com>
In-Reply-To: <20170527142126.26079-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> + * blk_mq_unquiesce_queue() - pair of blk_mq_quiesce_queue()
                                 ^^^^=20

Sorry but that comment is incomprehensible to me. Did you perhaps mean
"counterpart" instead of "pair"?

Bart.=
