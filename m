Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47331 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750851AbdANBFg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 20:05:36 -0500
From: Josef Bacik <jbacik@fb.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] nbd: create a recv workqueue per nbd device
Date: Sat, 14 Jan 2017 01:04:40 +0000
Message-ID: <C2506CBE-045B-4644-A0FD-4A8BA2F4EFD1@fb.com>
References: <1484322673-10606-1-git-send-email-jbacik@fb.com>,<ef333dc1-64c6-ac46-5dd3-c62509e7dd89@grimberg.me>
In-Reply-To: <ef333dc1-64c6-ac46-5dd3-c62509e7dd89@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On Jan 13, 2017, at 5:24 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>=20
> Hey Josef,
>=20
>> Since we are in the memory reclaim path we need our recv work to be on a
>> workqueue that has WQ_MEM_RECLAIM set so we can avoid deadlocks.  Also
>> set WQ_HIGHPRI since we are in the completion path for IO.
>=20
> Really a workqueue per device?? Did this really give performance
> advantage? Can this really scale with number of devices?

I don't see why not, especially since these things run the whole time the d=
evice is active.  I have patches forthcoming to make device creation dynami=
c so we don't have a bunch all at once.  That being said I'm not married to=
 the idea, just seemed like a good idea at the time and not particularly ha=
rmful.  Thanks,

Josef=
