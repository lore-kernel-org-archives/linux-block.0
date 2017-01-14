Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48183 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750894AbdANBSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 20:18:51 -0500
From: Josef Bacik <jbacik@fb.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] nbd: use an idr to keep track of nbd devices
Date: Sat, 14 Jan 2017 01:18:42 +0000
Message-ID: <DB56A2D2-42FA-46F4-A250-F5E987CB5E61@fb.com>
References: <1484334292-29933-1-git-send-email-jbacik@fb.com>,<0439c54d-228c-78fb-4790-94095ef39c93@grimberg.me>
In-Reply-To: <0439c54d-228c-78fb-4790-94095ef39c93@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On Jan 13, 2017, at 5:41 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>=20
> Hey Josef,
>=20
>> To prepare for dynamically adding new nbd devices to the system switch
>> from using an array for the nbd devices and instead use an idr.  This
>> copies what loop does for keeping track of its devices.
>=20
> I think ida_simple_* is simpler and sufficient here isn't it?

I use more of the IDR stuff in later patches, I just haven't posted those y=
et because meetings.  Thanks,

Josef=
