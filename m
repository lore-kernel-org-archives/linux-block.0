Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960C9C43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC1B2176D
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 08:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TJEAdp6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLQIAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:00:11 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:34212 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLQIAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 03:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576569610; x=1608105610;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=MK/ntvqgD4ldTAcOBUpr88W3nXXK3upz67rIo5vkCJA=;
  b=TJEAdp6lldoe+IPNZ8nEoK2LPudUHu6oTgBsNLdzXJ4OZy6FZ1ebfDUY
   bELe+/CXksvn946g1qzE1O1ezoUZdRKyP8JgNOy768B3KYVR8V4QSIJp+
   uK9EIX/W8N3DRhzff0EUKXCPx5MO+TlhBBPkrt1LLtqmsGITtJGse9B+H
   Y=;
IronPort-SDR: dQl3FfbwDFzEi5+WHu2uoScZ6eke6A7B/RL+g0Mrj1b2ivor+lL+j1uvfXSJe7e8020yBgpm9Y
 BP0Qpso9a5ng==
X-IronPort-AV: E=Sophos;i="5.69,324,1571702400"; 
   d="scan'208";a="5549576"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 17 Dec 2019 07:59:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id A7958A06B3;
        Tue, 17 Dec 2019 07:59:56 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 07:59:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 07:59:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sj38.park@gmail.com>, <axboe@kernel.dk>,
        <konrad.wilk@oracle.com>, <pdurrant@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <roger.pau@citrix.com>
Subject: Re: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Tue, 17 Dec 2019 08:59:32 +0100
Message-ID: <20191217075932.4516-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <c4efaabf-a925-0af0-b772-49a2e15623e7@suse.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D35UWB001.ant.amazon.com (10.43.161.47) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 17 Dec 2019 07:23:12 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

> On 16.12.19 20:48, SeongJae Park wrote:
> > On on, 16 Dec 2019 17:23:44 +0100, Jürgen Groß wrote:
> > 
> >> On 16.12.19 17:15, SeongJae Park wrote:
> >>> On Mon, 16 Dec 2019 15:37:20 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> >>>
> >>>> On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> >>>>
> >>>>> From: SeongJae Park <sjpark@amazon.de>
> >>>>>
> >>> [...]
> >>>>> --- a/drivers/block/xen-blkback/xenbus.c
> >>>>> +++ b/drivers/block/xen-blkback/xenbus.c
> >>>>> @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
> >>>>>    }
> >>>>>    
> >>>>>    
> >>>>> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> >>>>> +static unsigned int buffer_squeeze_duration_ms = 10;
> >>>>> +module_param_named(buffer_squeeze_duration_ms,
> >>>>> +		buffer_squeeze_duration_ms, int, 0644);
> >>>>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> >>>>> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> >>>>> +
> >>>>> +/*
> >>>>> + * Callback received when the memory pressure is detected.
> >>>>> + */
> >>>>> +static void reclaim_memory(struct xenbus_device *dev)
> >>>>> +{
> >>>>> +	struct backend_info *be = dev_get_drvdata(&dev->dev);
> >>>>> +
> >>>>> +	be->blkif->buffer_squeeze_end = jiffies +
> >>>>> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> >>>>
> >>>> This callback might race with 'xen_blkbk_probe()'.  The race could result in
> >>>> __NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
> >>>> 'be' to the 'dev'.  Please _don't merge_ this patch now!
> >>>>
> >>>> I will do more test and share results.  Meanwhile, if you have any opinion,
> >>>> please let me know.
> > 
> > I reduced system memory and attached bunch of devices in short time so that
> > memory pressure occurs while device attachments are ongoing.  Under this
> > circumstance, I was able to see the race.
> > 
> >>>
> >>> Not only '->blkif', but 'be' itself also coule be a NULL.  As similar
> >>> concurrency issues could be in other drivers in their way, I suggest to change
> >>> the reclaim callback ('->reclaim_memory') to be called for each driver instead
> >>> of each device.  Then, each driver could be able to deal with its concurrency
> >>> issues by itself.
> >>
> >> Hmm, I don't like that. This would need to be changed back in case we
> >> add per-guest quota.
> > 
> > Extending this callback in that way would be still not too hard.  We could use
> > the argument to the callback.  I would keep the argument of the callback to
> > 'struct device *' as is, and will add a comment saying 'NULL' value of the
> > argument means every devices.  As an example, xenbus would pass NULL-ending
> > array of the device pointers that need to free its resources.
> > 
> > After seeing this race, I am now also thinking it could be better to delegate
> > detailed control of each device to its driver, as some drivers have some
> > complicated and unique relation with its devices.
> > 
> >>
> >> Wouldn't a get_device() before calling the callback and a put_device()
> >> afterwards avoid that problem?
> > 
> > I didn't used the reference count manipulation operations because other similar
> > parts also didn't.  But, if there is no implicit reference count guarantee, it
> > seems those operations are indeed necessary.
> > 
> > That said, as get/put operations only adjust the reference count, those will
> > not make the callback to wait until the linking of the 'backend' and 'blkif' to
> > the device (xen_blkbk_probe()) is finished.  Thus, the race could still happen.
> > Or, am I missing something?
> 
> No, I think we need a xenbus lock per device which will need to be
> taken in xen_blkbk_probe(), xenbus_dev_remove() and while calling the
> callback.

I also agree that locking should be used at last.  But, as each driver manages
its devices and resources in their way, it could have its unique race
conditions.  And, each unique race condition might have its unique efficient
way to synchronize it.  Therefore, I think the synchronization should be done
by each driver, not by xenbus and thus we should make the callback to be called
per-driver.


Thanks,
SeongJae Park

> 
> 
> Juergen
> 
