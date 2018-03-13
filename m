Return-Path: <linux-block-owner@vger.kernel.org>
Received: from othala.iewc.co.za ([154.73.34.12]:36786 "EHLO othala.uls.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeCMPAG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 11:00:06 -0400
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "pieterk@uls.co.za" <pieterk@uls.co.za>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
 <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
 <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
 <1520737695.8740.4.camel@wdc.com>
 <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
 <1520744455.8740.9.camel@wdc.com>
 <0d5c21c2-4fea-5870-e971-f90556fb4141@uls.co.za>
 <1520950225.2921.0.camel@wdc.com>
From: Jaco Kroon <jaco@uls.co.za>
Message-ID: <cca75546-a02e-bed3-fda0-0003ccc5d158@uls.co.za>
Date: Tue, 13 Mar 2018 16:59:56 +0200
MIME-Version: 1.0
In-Reply-To: <1520950225.2921.0.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,


On 13/03/2018 16:10, Bart Van Assche wrote:
> On Tue, 2018-03-13 at 11:30 +0200, Jaco Kroon wrote:
>> On 11/03/2018 07:00, Bart Van Assche wrote:
>>> Did I see correctly that /dev/sdm is behind a MPT SAS controller? You may
>>> want to contact the authors of this driver and Cc the linux-scsi mailing
>>> list. Sorry but I'm not familiar with the mpt3sas driver myself.
>> You did see correctly, all drives are behind the MPT SAS.  If there is
>> in fact a problem with the driver (or the controller itself for that
>> matter) it would explain things.  It would also explain why we don't see
>> this problem on other hosts.
> You may want to have a look at the following report, something I ran into
> myself yesterday: https://marc.info/?l=linux-scsi&m=152087904024146.
I quickly checked my dmesg logs and I'm not seeing that particular
message, could be that newer kernels only started warning about it?

I'm not seeing any references to the
scsih_get_enclosure_logicalid_chassis_slot() function in the code here,
so there is obviously a newer driver in newer kernels.  The scsih_get_*
calls I do see is in mpt3sas_scsih.c and I'm not seeing (direct) calls
to _config_request at all.  At least it seems there is activity on the
driver, which is always a good sign that someone is attending to problems.

I'll queue an upgrade to 4.16 so long for when it's released in a couple
of days/weeks.

Kind Regards,
Jaco
