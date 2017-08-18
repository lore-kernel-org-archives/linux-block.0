Return-Path: <longman@redhat.com>
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
 <20170817093444.3276f7ab@gandalf.local.home>
 <b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
 <20170817171007.1ab33b8f@gandalf.local.home>
 <6bb40f9f-7f55-28b4-812b-a80f05bec6ea@redhat.com>
 <20170817181320.60b02500@gandalf.local.home>
 <20170817181818.4ef4acf3@gandalf.local.home>
 <20170817192343.503fac3d@gandalf.local.home>
From: Waiman Long <longman@redhat.com>
Message-ID: <7073443d-1bf7-c087-6065-1bf73adb97a1@redhat.com>
Date: Fri, 18 Aug 2017 09:42:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170817192343.503fac3d@gandalf.local.home>
Content-Type: multipart/mixed;
 boundary="------------067D991C8497D2EEDB39A92D"
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.
--------------067D991C8497D2EEDB39A92D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 08/17/2017 07:23 PM, Steven Rostedt wrote:
> On Thu, 17 Aug 2017 18:18:18 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Thu, 17 Aug 2017 18:13:20 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> On Thu, 17 Aug 2017 17:27:22 -0400
>>> Waiman Long <longman@redhat.com> wrote:
>>>
>>>   
>>>> It is actually what the patch is trying to do by checking for the
>>>> deletion flag in the mutex_trylock loop. Please note that mutex does not
>>>> guarantee FIFO ordering of lock acquisition. As a result, cpu1 may call
>>>> mutex_lock() and wait for it while cpu2 can set the deletion flag later
>>>> and get the mutex first before cpu1. So checking for the deletion flag
>>>> before taking the mutex isn't enough.    
>>> Yeah, I figured that out already (crossed emails). BTW, how did you
>>> trigger this warning. I'm playing around with adding loop devices,
>>> volume groups, and logical volumes, and reading the trace files
>>> created in the sysfs directory, then removing those items, but it's
>>> not triggering the "delete" path. What operation deletes the partition?  
>> I'm guessing that deleting an actual partition may work (unfortunately,
>> my test box has no partition to delete ;-) I'll find another box to
>> test on.
>>
> OK, deleting a partition doesn't trigger the lockdep splat. But I also
> added a printk in the BLKPG_DEL_PARTITION case switch, which also
> doesn't print. What command do I need to do to trigger that path?
>
> Thanks,
>
> -- Steve

Attached is a reproducer that was used to trigger the warning. Some
tuning may be needed depend on the actual configuration of the test machine.

Cheers,
Longman


--------------067D991C8497D2EEDB39A92D
Content-Type: application/x-shellscript;
 name="run_test.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="run_test.sh"

IyEvYmluL2Jhc2gKCnRydW5jYXRlIC1zIDFHIHRlc3RmaWxlCnBhcnRlZCAtcyAtLSB0ZXN0
ZmlsZSBta2xhYmVsIGdwdCBta3BhcnQgcHJpbWFyeSAyMDQ4cyAxMDAlCmxvb3BfZGV2aWNl
PWBsb3NldHVwIC0tc2hvdyAtZlAgdGVzdGZpbGVgCnBhcnR4IC1kICRsb29wX2RldmljZQpj
YXQgL3N5cy9ibG9jay9kbS0yL3RyYWNlL2FjdF9tYXNrIAoK
--------------067D991C8497D2EEDB39A92D--
