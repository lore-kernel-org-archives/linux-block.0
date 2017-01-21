Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58473 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750817AbdAUOGd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jan 2017 09:06:33 -0500
From: Josef Bacik <jbacik@fb.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, Jens Axboe <axboe@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/4] miscdevice: add a minor number for nbd-control
Date: Sat, 21 Jan 2017 13:25:32 +0000
Message-ID: <6013F363-5561-446C-B78E-66F3B0C3A298@fb.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-2-git-send-email-jbacik@fb.com>,<20170121090346.GA27048@kroah.com>
In-Reply-To: <20170121090346.GA27048@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On Jan 21, 2017, at 4:03 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
>> On Fri, Jan 20, 2017 at 04:56:50PM -0500, Josef Bacik wrote:
>> NBD is moving to a loop-control esque way of managing it's device
>> creation and deletion.  Reserver a minor number for the new device.
>>=20
>> Signed-off-by: Josef Bacik <jbacik@fb.com>
>> ---
>> include/linux/miscdevice.h | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
>> index ed30d5d..7e5c140 100644
>> --- a/include/linux/miscdevice.h
>> +++ b/include/linux/miscdevice.h
>> @@ -44,6 +44,7 @@
>> #define MISC_MCELOG_MINOR    227
>> #define HPET_MINOR        228
>> #define FUSE_MINOR        229
>> +#define NBD_CTRL_MINOR        230
>=20
> Ick, really?  Why not just use a dynamic one?  What 1990's-based systems
> are you running that you would need a static misc device number for?
>=20

Honestly I was just doing what loop did, I wasn't sure if there was some ad=
ministration reason for needing a static minor number.  If nobody cares the=
n I can just use a dynamic one.  Thanks,

Josef=
