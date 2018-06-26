Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13817 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeFZPZl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 11:25:41 -0400
Subject: Re: [PATCH blktests 15/15] Add tests for the SRP initiator and target
 drivers
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <20180622221946.10987-16-bart.vanassche@wdc.com>
 <20180626085757.ih6toex5ovpefwez@linux-x5ow.site>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <eed94957-58cd-3fe0-3447-a1d97cd0b9a9@wdc.com>
Date: Tue, 26 Jun 2018 08:25:40 -0700
MIME-Version: 1.0
In-Reply-To: <20180626085757.ih6toex5ovpefwez@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/26/18 01:58, Johannes Thumshirn wrote:
> On Fri, Jun 22, 2018 at 03:19:46PM -0700, Bart Van Assche wrote:
>>   tests/srp/functions | 1288 +++++++++++++++++++++++++++++++++++++++++++
> 
> Can you please move these into common/srp?

Let's do that once other tests than those in tests/srp need one or more 
of the functions defined in that file.

Bart.
