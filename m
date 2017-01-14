Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57943 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751831AbdANV2e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 16:28:34 -0500
From: Josef Bacik <jbacik@fb.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] nbd: create a recv workqueue per nbd device
Date: Sat, 14 Jan 2017 21:27:29 +0000
Message-ID: <3E2E6362-6863-4633-904C-C758B862AA8A@fb.com>
References: <1484322673-10606-1-git-send-email-jbacik@fb.com>
 <ef333dc1-64c6-ac46-5dd3-c62509e7dd89@grimberg.me>
 <C2506CBE-045B-4644-A0FD-4A8BA2F4EFD1@fb.com>,<cd41cf6a-ea9b-8759-ce26-de850ef04e16@grimberg.me>
In-Reply-To: <cd41cf6a-ea9b-8759-ce26-de850ef04e16@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On Jan 14, 2017, at 4:15 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>=20
>=20
>>> Hey Josef,
>>>=20
>>>> Since we are in the memory reclaim path we need our recv work to be on=
 a
>>>> workqueue that has WQ_MEM_RECLAIM set so we can avoid deadlocks.  Also
>>>> set WQ_HIGHPRI since we are in the completion path for IO.
>>>=20
>>> Really a workqueue per device?? Did this really give performance
>>> advantage? Can this really scale with number of devices?
>>=20
>> I don't see why not, especially since these things run the whole time th=
e device is active.  I have patches forthcoming to make device creation dyn=
amic so we don't have a bunch all at once.  That being said I'm not married=
 to the idea, just seemed like a good idea at the time and not particularly=
 harmful.  Thanks,
>=20
> I just don't see how having a worqueue per device helps anything? There
> are plenty of active workers per workqueue and even if its not enough
> you can specify more with max_active.
>=20
> I guess what I'm trying to say is that I don't understand what this is
> solving. The commit message explains why you need WQ_MEM_RECLAIM and why
> you want WQ_HIGHPRI, but does not explain why workqueue per device is
> helping/solving anything.

There's no reason for it, that's just the way I did it. I will test both wa=
ys on Tuesday and if there's no measurable difference then I'll do a global=
 one.  Thanks,

Josef=
