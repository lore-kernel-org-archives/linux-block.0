Return-Path: <lsf-bounces@lists.linux-foundation.org>
To: Paolo Valente <paolo.valente@linaro.org>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <cover.1489787289.git.osandov@fb.com>
	<46f16799-86d9-7bf5-6346-be08801dd48e@suse.de>
	<C191DA3B-3852-4304-A534-008088F97BA7@linaro.org>
Date: Sat, 18 Mar 2017 16:18:10 -0400
In-Reply-To: <C191DA3B-3852-4304-A534-008088F97BA7@linaro.org> (Paolo
	Valente's message of "Sat, 18 Mar 2017 07:15:52 -0400")
Message-ID: <yq1o9wyjq4d.fsf@oracle.com>
MIME-Version: 1.0
Cc: linux-block@vger.kernel.org, lsf@lists.linux-foundation.org,
	Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [Lsf] [RFC PATCH 0/4] blk-mq: multiqueue I/O scheduler
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf>,
	<mailto:lsf-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf/>
List-Post: <mailto:lsf@lists.linux-foundation.org>
List-Help: <mailto:lsf-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf>,
	<mailto:lsf-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-bounces@lists.linux-foundation.org
Errors-To: lsf-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

Paolo Valente <paolo.valente@linaro.org> writes:


>> And actually, I have been looking at properly supporting host-wide tag
>> maps, so the concept of 'shallow' queue depth might be the way to go here.
>> 
>> And as I have some other questions, too (assigning a new tag on
>> requeue?) it might be an idea to spread this out into a formal session
>> at LSF. If there are some slots left, that is.
>> 
>
> I would be very interested in such a discussion too.

OK. Added.

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Lsf mailing list
Lsf@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf
