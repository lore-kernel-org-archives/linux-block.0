Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14207 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdE3PTp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 11:19:45 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2 2/8] block: introduce flag of QUEUE_FLAG_QUIESCED
Date: Tue, 30 May 2017 15:11:26 +0000
Message-ID: <1496157085.2627.6.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <20170527142126.26079-3-ming.lei@redhat.com>
In-Reply-To: <20170527142126.26079-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> This flag is introduced for fixing & improving the quiescing code.

Hello Ming,

Since the quiescing code works fine, a better description would be that the
purpose of this flag is to allow block drivers to use both the queue stoppi=
ng
and queue quiescing mechanisms instead of only one of these two mechanisms.

Bart.=
