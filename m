Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48625 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753717AbdA0CBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 21:01:23 -0500
Subject: Re: [dm-devel] split scsi passthrough fields out of struct request V2
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "hch@lst.de" <hch@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
 <1485455329.2540.7.camel@sandisk.com>
 <e8f4b084-be66-d5b3-5785-13b80642040f@fb.com>
 <1485456745.2540.9.camel@sandisk.com>
 <db7f9165-19db-d1f2-a2fa-7546da57741b@fb.com> <20170126185924.GA25289@lst.de>
 <ee95c6dd-cdb4-7da5-2d4a-ec14034eac7a@fb.com>
 <71e22257-0592-fdd3-25e5-a78ceced2ab9@sandisk.com>
 <4054e944-b28d-1cd6-574f-6cd90e28c301@fb.com>
 <1485464486.2540.12.camel@sandisk.com>
 <6995c991-65a4-8dca-c36e-fb2eff277ca9@fb.com>
 <1485467235.2540.14.camel@sandisk.com>
 <e1d5f4e6-c63f-545d-710f-d4d10fa8d2e0@fb.com>
 <1485472465.2540.19.camel@sandisk.com>
 <e222c541-3239-104d-e0b0-40d19b012b66@fb.com>
 <1485474426.2540.25.camel@sandisk.com>
 <b98195e7-6e04-5a59-8b83-ce2e1c5c4e1a@fb.com>
 <1485477510.2540.27.camel@sandisk.com>
 <2d971693-b79d-c1b9-fb2a-f5dd04128c68@fb.com>
 <1485479738.2540.30.camel@sandisk.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <ecca734c-7a9c-f060-9335-c2de089849c2@fb.com>
Date: Thu, 26 Jan 2017 18:22:34 -0700
MIME-Version: 1.0
In-Reply-To: <1485479738.2540.30.camel@sandisk.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/26/2017 06:15 PM, Bart Van Assche wrote:
> On Thu, 2017-01-26 at 17:41 -0700, Jens Axboe wrote:
>> On 01/26/2017 05:38 PM, Bart Van Assche wrote:
>>> I see similar behavior with the blk-mq-sched branch of
>>> git://git.kernel.dk/linux-block.git (git commit ID 0efe27068ecf):
>>> booting happens much slower than usual and I/O hangs if I run the
>>> srp-test software.
>>
>> Please don't run that, run for-4.11/block and merge it to master.
>> Same behavior?
> 
> I have not yet had the chance to run the srp-test software against that
> kernel. But I already see that booting takes more than ten times longer
> than usual. Note: as far as I know the dm-mpath driver is not involved
> in the boot process of my test system.

What's your boot device? I've been booting this on a variety of setups,
no problems observed. It's booting my laptop, and on SCSI and SATA as
well. What is your root drive? What is the queue depth of it?
Controller?

-- 
Jens Axboe

