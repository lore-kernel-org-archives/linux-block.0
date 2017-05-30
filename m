Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49875 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdE3Saw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 14:30:52 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-block@vger.kernel.org
Subject: Re: WARNING triggers at blk_mq_update_nr_hw_queues during nvme_reset_work
References: <8760giqnyb.fsf@dilma.collabora.co.uk>
        <20170530175549.GC2845@localhost.localdomain>
Date: Tue, 30 May 2017 15:30:46 -0300
In-Reply-To: <20170530175549.GC2845@localhost.localdomain> (Keith Busch's
        message of "Tue, 30 May 2017 13:55:49 -0400")
Message-ID: <87bmqanqnd.fsf@dilma.collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Keith Busch <keith.busch@intel.com> writes:

> On Tue, May 30, 2017 at 02:00:44PM -0300, Gabriel Krisman Bertazi wrote:
>> Since the merge window for 4.12, one of the machines in Intel's CI
>> started to hit the WARN_ON below at blk_mq_update_nr_hw_queues during an
>> nvme_reset_work.  The issue persists with the latest 4.12-rc3, and full
>> dmesg from boot, up to the moment where the WARN_ON triggers is
>> available at the following link:
>> 
>> https://intel-gfx-ci.01.org/CI/CI_DRM_2672/fi-kbl-7500u/igt@kms_pipe_crc_basic@suspend-read-crc-pipe-a.html
>> 
>> Please notice that the test we do in the CI involves putting the
>> machine to sleep (PM), and the issue triggers when resuming execution.
>> 
>> I have not been able to get my hands on the machine yet to do an actual
>> bisect, but I'm wondering if you guys might have an idea of what is
>> wrong.
>> 
>> Any help is appreciated :)
>
> Hi Gabriel,
>
> This appears to be new behavior in blk-mq's tag set update with commit
> 705cda97e. This is asserting a lock is held, but none of the drivers
> that call the export are take that lock.
>
> I think the below should fix it (CC'ing block list and developers).
>

Thanks for the quick fix, Keith.  I'm running it against the CI to
confirm it fixes the issue and will send you my tested-by once the job
is completed.

-- 
Gabriel Krisman Bertazi
