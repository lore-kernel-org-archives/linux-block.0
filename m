Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E62C43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E45206DD
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 17:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rt8QBixJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbeLNRUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:20:03 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37519 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbeLNRUD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 12:20:03 -0500
Received: by mail-wr1-f51.google.com with SMTP id s12so5730683wrt.4
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+L/Xa4nSgl6M/pAOyfFhKmrIEsyObgW0w2rd3z2sdOM=;
        b=Rt8QBixJinpGlsaUooD6fAUl9BEl5dDLI2Jl4J5+4zQGCAD/g801tCifVb5NlfPEZb
         CJMjB8UU0Pof8sW5zoNVh65n2g7BlJF2r2W2i/2zH84etYNr4pYW/myul2jVFrEJFEuH
         hmluAgB5yfYlVdkXUw3qKrYqRal56An+b5Dec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+L/Xa4nSgl6M/pAOyfFhKmrIEsyObgW0w2rd3z2sdOM=;
        b=GLs+VExeUPuyN+1c8zr/6WTkIDVcsQNlrV09TdyVYCyDIL2e7Ub2pjxbURKyyrviJK
         tdQbtmFuZhzLwUQkt2UeXGyJeJLlZOmXE3cPquch2sJd4OEEuf0+EM1XHQ5w5xwHvVPT
         jx7sLRDhSkxMYnsPLk0KXX9X9cghZxbM0am7CUSlfXXn7Y5dkpIdSz1ogsyK6G/qSQhy
         LhBYQAmVg5yTj2Y/W1mmiF2b81tT2ax0ZNOEZYBaXgv7mfqja0K9aBjKhjyBJm8tXMpz
         X7XHY0oMnCG4mlQXBdKD9C3q54PNkorGhvfd1Jau1J4vkabcgS5yrNNgDvTNGeVqtWAi
         iccQ==
X-Gm-Message-State: AA+aEWaQvKyldIXctoEsUJK72nfbsfOiJOVmel01IRR1vfVJaFpoD80L
        SNKLwcI5VTq/Jd6n7fAt/cFe12ZQ800=
X-Google-Smtp-Source: AFSGD/X6k8Qey8F9jlBR8E0l6CfWh8KFDeOV1HXriW7P0UmUOJYhm111X1UzjlPotDGVzHk3RclwcQ==
X-Received: by 2002:adf:8464:: with SMTP id 91mr3493338wrf.251.1544808001010;
        Fri, 14 Dec 2018 09:20:01 -0800 (PST)
Received: from [192.168.0.103] (146-241-196-19.dyn.eolo.it. [146.241.196.19])
        by smtp.gmail.com with ESMTPSA id q9sm4854519wrv.26.2018.12.14.09.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:20:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: Unintuitive scheduling results using BFQ
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
Date:   Fri, 14 Dec 2018 18:19:58 +0100
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org>
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
 <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
To:     Madhav Ancha <mancha@tower-research.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 14 dic 2018, alle ore 14:55, Madhav Ancha =
<mancha@tower-research.com> ha scritto:
>=20
> Hi Paolo,
>=20
>    Thanks a lot for your work and your response to this email.
>=20

Thank you for trying bfq!

>    Following your advise, I switched my real time application to =
direct I/O.
>    We now have
>=20
>    Task1: Using ionice -c1, we run a RT IO/ O_DIRECT task that writes
> to flood the NVME drive to its capacity.
>    Task2: We run a normal (best-effort) IO/ asyn(page-cache buffered)
> task that writes to flood the NVME drive to its capacity.
>=20
>    What we now see is that Task2 still ends up getting about 3/5th or
> more of the NVMe bandwidth and Task1 ends up getting the rest of the
> NVMe disk bandwidth. Could the kernel threads/buffering be
> overpowering the RT priority of Task1?
>=20
>    What we desire is to loosely ensure that Task1 gets as much
> bandwidth as it asks for in any iteration while Task2 and the
> remaining tasks share the leftover bandwidth.
>=20
>    We are currently testing with these settings in BFQ.
>    low_latency =3D 0 (to control the bandwidth allocation)

This may be a good idea.  But, after we sort this out, you could try
leaving low_latency enabled.  It should cause no harm (I'm trying to
make bfq smarter and smarter).


>    slice_idle =3D 0     (we are using a fast NVMe and if Task1 does =
not
> have any requests and control goes to Task2, it seems to make sense we
> get the control back to Task1 quickly)

Unfortunately, this is not correct.  Setting slice_idle to 0 means
losing completely control on I/O.  And in you case you need ...
control :)

So, you'd better leave slice_idle as it is.

The actual problem is that, while thinking on whether it was
reasonable to set slice_idle =3D=3D 0, I realized that bfq is likely to =
fail
even with slice_idle > 0.  In fact, I have not checked the respect of
RT priority for probably a few years.  And I have changed lots of
critical operations in these years.

So, I'll wait for your feedback, which I do expect to be negative.
Then, if it is actually negative, I'll work on the bug behind the
failure.

>    timeout_sync =3D 1 (Task1 does application level buffering and =
sends
> the biggest chunk of data available (in high MB's) always)
>=20

Also for this one, things should go well even without touching it.
But we will find out after discovering whether bfq is broken for your
use case.

Looking forward to your feedback,
Paolo

>    We are unable to make the leap to cpugroups at this time Paolo. Is
> there anything we can tune in BFQ or change the way we generate
> traffic in Task1 to ensure that Task1 gets the bandwidth it asks for?
>=20
>    A rough approximation to the Task1 and Task2 traffic we discussed
> above seem to be these instantiations of dd.
>    Task1: ionice -c1 -n2 /bin/dd if=3D/dev/zero of=3D/n/ssd1/ddtestRT1
> bs=3D2M oflag=3Ddirect
>    Task2: /bin/dd if=3D/dev/zero of=3D/n/ssd1/ddtestRT2   bs=3D2M
>=20
> Thanks again Paolo,
> Madhav.
>=20
>=20
>=20
> On Fri, Dec 14, 2018 at 1:38 AM Paolo Valente =
<paolo.valente@linaro.org> wrote:
>>=20
>>=20
>>=20
>>> Il giorno 13 dic 2018, alle ore 21:34, Madhav Ancha =
<mancha@tower-research.com> ha scritto:
>>>=20
>>> In our setup, we have a task that writes to a NVMe SSD drive using =
the
>>> page cache. (using ::write os calls). This task does application =
level
>>> buffering and sends big (large MBs) chunks of data to ::write call.
>>> Each instance of the task writes upto 10Gbps of data to the NVME =
SSD.
>>>=20
>>> We run two instances of this task as below.
>>> Instance 1: Using ionice -c1, we run a RT IO instance of this task.
>>> Instance 2: We run a normal (best-effort) IO instance of this task.
>>>=20
>>> Both the write task instances compete for NVMe bandwidth. We observe
>>> that BFQ allocates equal bandwidth to both the task instances =
starting
>>> a few seconds after they start up.
>>>=20
>>> What we expected is that Instance1 (IOPRIO_CLASS_RT scheduling =
class)
>>> will be granted all the bandwidth it asked for while Instance2 will =
be
>>> allowed to consume the remaining bandwidth.
>>>=20
>>> Could you please help us understand how we may be able to design to
>>> get our expected behavior.
>>>=20
>>=20
>> Hi,
>> if you do async, in-memory writes, then your task instances just =
dirty
>> vm pages.  Then different processes, the kworkers, will do the
>> writeback of dirty pages asynchronously, according to the system
>> writeback logic and configuration.  kworkers have their own priority,
>> which is likely to be the same for each such process.  AFAICT this
>> priority is not related to the priority you give to your processes.
>>=20
>> If you want to control I/O bandwidths for writes, go for direct I/O =
or
>> use cgroups.  In case of cgroups, consider that there is still the
>> oddity that bfq interface parameters are non standard.  We have
>> proposed and are pushing for a solution to this problem [1].
>>=20
>> Thanks,
>> Paolo
>>=20
>> [1] https://lkml.org/lkml/2018/11/19/366
>>=20
>>> Thanks
>>=20

