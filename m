Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750800AbdAUNpW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jan 2017 08:45:22 -0500
From: Josef Bacik <jbacik@fb.com>
To: Wouter Verhelst <w@uter.be>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
Date: Sat, 21 Jan 2017 13:44:48 +0000
Message-ID: <BBF8194D-5D09-4A8E-9D43-AAC5CB6DB6A5@fb.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-4-git-send-email-jbacik@fb.com>,<20170121121149.2wdztzezil2bkcft@grep.be>
In-Reply-To: <20170121121149.2wdztzezil2bkcft@grep.be>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On Jan 21, 2017, at 7:12 AM, Wouter Verhelst <w@uter.be> wrote:
>=20
>> On Fri, Jan 20, 2017 at 04:56:52PM -0500, Josef Bacik wrote:
>> This patch mirrors the loop back device behavior with a few changes.  Fi=
rst
>> there is no DEL operation as NBD doesn't get as much churn as loop devic=
es do.
>> Secondly the GET_NEXT operation can optionally create a new NBD device o=
r not.
>> Our infrastructure people want to not allow NBD to create new devices as=
 it
>> causes problems for them in containers.  However allow this to be option=
al as
>> things like the OSS NBD client probably doesn't care and would like to j=
ust be
>> given a device to use.
>=20
> Don't be so sure :-)
>=20
> I agree that having a control device for NBD is useful and would make
> certain things much easier. If that's added, then I'll move to using
> that as a way to control the device rather than opening a device and
> dealing with it that way. In fact, at some point in the past I did
> suggest something along those ways myself; it's just not happened yet.
>=20
> Obviously though this would require an intermediate situation in which
> the control master would be available as well as (optionally perhaps)
> the old way where you open a specific device node, so that we don't
> break existing implementations before they've had a chance to follow
> suit.

Sorry I wasn't super clear.  This doesn't change anything about how the dev=
ices are setup, it just means if you do max_nbds=3D0 you can dynamically ad=
d more as you need them, and you can find unused nbd devices easily instead=
 of making the user specify them.  When I get home tonight I'll push my nbd=
-client patch so you can see how I use it.  Thanks,

Josef=
