Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10FC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6848621582
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qgw5V+G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfLQQR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:17:56 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:43915 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfLQQRu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576599470; x=1608135470;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=cXvLi4yNQxt3p65AJ8lZq7BOonBnO1ATPy+SuVrgHOI=;
  b=Qgw5V+G4nw8D2NrShzEM+ip/dbLpYy2Ggw8ILbE/QN2aJoVf7Z0BSQy8
   7s1V77I8tTJ8fcXF9rcX841hJD6Bnl3xCvQFnAfSbznyQ76Q277Hio+7z
   VRFnH2TweOQhwLSveIQWv2KurvGQnbAUJwAnyGpOxX8vEVkG/baDBOnj1
   Q=;
IronPort-SDR: SloTP35ntItl/SfHlYTc4zaNzogpagd/+j5Ygf9NYQzdLPnKww+k+nyZ6yb2Y5MwjvPTpmav48
 mXrbXNg6QeAg==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="14052216"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 17 Dec 2019 16:17:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 7BD78A2122;
        Tue, 17 Dec 2019 16:17:46 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:17:45 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:17:40 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>,
        <axboe@kernel.dk>, SeongJae Park <sj38.park@gmail.com>,
        <konrad.wilk@oracle.com>, <pdurrant@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <roger.pau@citrix.com>
Subject: Re: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Tue, 17 Dec 2019 17:17:24 +0100
Message-ID: <20191217161724.3478-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20191217083032.19400-1-sjpark@amazon.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D23UWC002.ant.amazon.com (10.43.162.22) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 17 Dec 2019 09:30:32 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> On Tue, 17 Dec 2019 09:16:47 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> 
> > On 17.12.19 08:59, SeongJae Park wrote:
> > > On Tue, 17 Dec 2019 07:23:12 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> > > 
> > >> On 16.12.19 20:48, SeongJae Park wrote:
> > >>> On on, 16 Dec 2019 17:23:44 +0100, Jürgen Groß wrote:
> > >>>
> > >>>> On 16.12.19 17:15, SeongJae Park wrote:
> > >>>>> On Mon, 16 Dec 2019 15:37:20 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> > >>>>>
> > >>>>>> On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> > >>>>>>
> > >>>>>>> From: SeongJae Park <sjpark@amazon.de>
> > >>>>>>>
> > >>>>> [...]
> > >>>>>>> --- a/drivers/block/xen-blkback/xenbus.c
> > >>>>>>> +++ b/drivers/block/xen-blkback/xenbus.c
> > >>>>>>> @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
> > >>>>>>>     }
> > >>>>>>>     
> > >>>>>>>     
> > >>>>>>> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> > >>>>>>> +static unsigned int buffer_squeeze_duration_ms = 10;
> > >>>>>>> +module_param_named(buffer_squeeze_duration_ms,
> > >>>>>>> +		buffer_squeeze_duration_ms, int, 0644);
> > >>>>>>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> > >>>>>>> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> > >>>>>>> +
> > >>>>>>> +/*
> > >>>>>>> + * Callback received when the memory pressure is detected.
> > >>>>>>> + */
> > >>>>>>> +static void reclaim_memory(struct xenbus_device *dev)
> > >>>>>>> +{
> > >>>>>>> +	struct backend_info *be = dev_get_drvdata(&dev->dev);
> > >>>>>>> +
> > >>>>>>> +	be->blkif->buffer_squeeze_end = jiffies +
> > >>>>>>> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> > >>>>>>
> > >>>>>> This callback might race with 'xen_blkbk_probe()'.  The race could result in
> > >>>>>> __NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
> > >>>>>> 'be' to the 'dev'.  Please _don't merge_ this patch now!
> > >>>>>>
> > >>>>>> I will do more test and share results.  Meanwhile, if you have any opinion,
> > >>>>>> please let me know.
> > >>>
> > >>> I reduced system memory and attached bunch of devices in short time so that
> > >>> memory pressure occurs while device attachments are ongoing.  Under this
> > >>> circumstance, I was able to see the race.
> > >>>
> > >>>>>
> > >>>>> Not only '->blkif', but 'be' itself also coule be a NULL.  As similar
> > >>>>> concurrency issues could be in other drivers in their way, I suggest to change
> > >>>>> the reclaim callback ('->reclaim_memory') to be called for each driver instead
> > >>>>> of each device.  Then, each driver could be able to deal with its concurrency
> > >>>>> issues by itself.
> > >>>>
> > >>>> Hmm, I don't like that. This would need to be changed back in case we
> > >>>> add per-guest quota.
> > >>>
> > >>> Extending this callback in that way would be still not too hard.  We could use
> > >>> the argument to the callback.  I would keep the argument of the callback to
> > >>> 'struct device *' as is, and will add a comment saying 'NULL' value of the
> > >>> argument means every devices.  As an example, xenbus would pass NULL-ending
> > >>> array of the device pointers that need to free its resources.
> > >>>
> > >>> After seeing this race, I am now also thinking it could be better to delegate
> > >>> detailed control of each device to its driver, as some drivers have some
> > >>> complicated and unique relation with its devices.
> > >>>
> > >>>>
> > >>>> Wouldn't a get_device() before calling the callback and a put_device()
> > >>>> afterwards avoid that problem?
> > >>>
> > >>> I didn't used the reference count manipulation operations because other similar
> > >>> parts also didn't.  But, if there is no implicit reference count guarantee, it
> > >>> seems those operations are indeed necessary.
> > >>>
> > >>> That said, as get/put operations only adjust the reference count, those will
> > >>> not make the callback to wait until the linking of the 'backend' and 'blkif' to
> > >>> the device (xen_blkbk_probe()) is finished.  Thus, the race could still happen.
> > >>> Or, am I missing something?
> > >>
> > >> No, I think we need a xenbus lock per device which will need to be
> > >> taken in xen_blkbk_probe(), xenbus_dev_remove() and while calling the
> > >> callback.
> > > 
> > > I also agree that locking should be used at last.  But, as each driver manages
> > > its devices and resources in their way, it could have its unique race
> > > conditions.  And, each unique race condition might have its unique efficient
> > > way to synchronize it.  Therefore, I think the synchronization should be done
> > > by each driver, not by xenbus and thus we should make the callback to be called
> > > per-driver.
> > 
> > xenbus controls creation and removing of devices, so applying locking
> > at xenbus level is the right thing to do in order to avoid races with
> > device removal.
> > 
> > In case a backend has further synchronization requirements those have to
> > be handled at backend level, of course.
> > 
> > In the end you'll need the xenbus level locking anyway in order to avoid
> > a race when the last backend specific device is just being removed when
> > the callback is about to be called for that device. Or you'd need to
> > call try_get_module() before calling into each backend...
> 
> Agreed.  Thank you for your kind explanation of your concerns.

Just posted the v11 patchset[1], which is based on your idea and passed my
test.

[1] https://lore.kernel.org/xen-devel/20191217160748.693-1-sjpark@amazon.com/


Thanks,
SeongJae Park

> 
> 
> Thanks,
> SeongJae Park
> 
> > 
> > 
> > Juergen
