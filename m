Return-Path: <axboe@kernel.dk>
Subject: Re: WARNING triggers at blk_mq_update_nr_hw_queues during
 nvme_reset_work
To: Keith Busch <keith.busch@intel.com>,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: linux-nvme@lists.infradead.org,
 Bart Van Assche <bart.vanassche@sandisk.com>, linux-block@vger.kernel.org
References: <8760giqnyb.fsf@dilma.collabora.co.uk>
 <20170530175549.GC2845@localhost.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d691962d-eeac-bc59-8377-cf465f6219b2@kernel.dk>
Date: Tue, 30 May 2017 12:26:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170530175549.GC2845@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/30/2017 11:55 AM, Keith Busch wrote:
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

Ugh yes, that was a little sloppy... Would you mind sending this as
a proper patch? Then I'll queue it up for 4.12.

-- 
Jens Axboe
