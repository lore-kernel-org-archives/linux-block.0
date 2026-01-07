Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903B33507E
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813995; cv=none; b=gP5RV6GdTnw1QogDuO1aRx2bSQcq66Vp1wBL6I8FgkNJYNzQWTrx1N3C+pEMnvIORQslUC8ED4whhtR9p7Na3pyh6l33j7wi2Dkfj5SqkEd1OqqmjltrkoEj2WeAjLqvD9IltgDK3XxluYnZ2SD+AOOPfLxxBvOVlUslPSnv22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813995; c=relaxed/simple;
	bh=MTYMrV+Yymv4Cd/avn0CLByEMclgUVINm5O/bdwOWB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMPlearbD6Llm240DLfpigJ2znUaMdUpga8ZuZu2CmLYuDAwkxb1ukQPt2fCr3uFyGggqODoa7wi3/oJgQunFcC9onlPUEgAf4+W2vrSM145ZIUf6GOf4bmGnhwApk4b0RI1RE3PSM+zDC2eC2+L1bj+Hl29XjXCc8tFubAraM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ksCe5Bo/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ksCe5Bo/"
Message-ID: <e26b8ff0-c176-4d94-a25a-4e29992611c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767813980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcB8G3y5iz+8intAQ2MzrTuvbBYtEhwRblwqeC5cVu4=;
	b=ksCe5Bo/EPvK+Yybn2Q4RtDdQIIfm2yAJStNI/8d7/7WVqQsANcOBJj465bf6HWSAzwhLs
	Ty4edCKZq2IY9d/jXLadET9lMp3SLgo6JPTJ5EHVC7LP/fu65QsgKSjByKGo5N8Wg51DKP
	oMU66hLaVaQ2xlxQfVuoWnI746hW/ig=
Date: Wed, 7 Jan 2026 11:26:16 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: kernel build failure when CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN
 are enabled
Content-Language: en-GB
To: Nilay Shroff <nilay@linux.ibm.com>, Alan Adamson
 <alan.adamson@oracle.com>, bpf@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/26/25 2:29 AM, Nilay Shroff wrote:
> Hi,
>
> I am encountering the following build failures when compiling the kernel source checked out
> from the for-6.19/block branch [1]:
>
>    KSYMS   .tmp_vmlinux2.kallsyms.S
>    AS      .tmp_vmlinux2.kallsyms.o
>    LD      vmlinux.unstripped
>    BTFIDS  vmlinux.unstripped
> WARN: multiple IDs found for 'task_struct': 110, 3046 - using 110
> WARN: multiple IDs found for 'module': 170, 3055 - using 170
> WARN: multiple IDs found for 'file': 697, 3130 - using 697
> WARN: multiple IDs found for 'vm_area_struct': 714, 3140 - using 714
> WARN: multiple IDs found for 'seq_file': 1060, 3167 - using 1060
> WARN: multiple IDs found for 'cgroup': 2355, 3304 - using 2355
> WARN: multiple IDs found for 'inode': 553, 3339 - using 553
> WARN: multiple IDs found for 'path': 586, 3369 - using 586
> WARN: multiple IDs found for 'bpf_prog': 2565, 3640 - using 2565
> WARN: multiple IDs found for 'bpf_map': 2657, 3837 - using 2657
> WARN: multiple IDs found for 'bpf_link': 2849, 3965 - using 2849
> [...]
> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> make[2]: *** Deleting file 'vmlinux.unstripped'
> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
>
> The build failure appears after commit 42adb2d4ef24 (“fs: Add the __data_racy annotation
> to backing_dev_info.ra_pages”) and commit 935a20d1bebf (“block: Remove queue freezing
> from several sysfs store callbacks”). However, the root cause does not seem to be specific
> to these commits or to the block layer changes themselves. Instead, the issue is triggered
> by the introduction of the __data_racy annotation on several fields in struct request_queue
> and struct backing_dev_info.
>
> It seems likely that some compilation units are built with KCSAN disabled, in which case
> the preprocessor expands __data_racy to nothing. Other units have KCSAN enabled, where
> __data_racy expands to the volatile qualifier. This results in two different versions
> of both struct request_queue and struct backing_dev_info: one where fields such as
> rq_timeout or ra_pages are declared volatile, and another where they are not.
>
> During BTF generation, the resolver encounters these conflicting type definitions.
> Although the reported error does not explicitly reference struct request_queue or
> struct backing_dev_info, it likely surfaces through types such as task_struct or
> others that embed these structures deep within their type hierarchies.
>
> For reference, gcc and pahole versions are shown below. Also, attached kernel .config:
>
> # gcc --version
> gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3)
> Copyright (C) 2021 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> # pahole --version
> v1.27
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-6.19/block

I tried with clang with CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN enabled.
I am using the latest bpf-next.
   $ make LLVM=1 -j
   ...
   KSYMS   .tmp_vmlinux0.kallsyms.S
   AS      .tmp_vmlinux0.kallsyms.o
   LD      .tmp_vmlinux1
   BTF     .tmp_vmlinux1
      <==== hang here

^Cmake[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:72: vmlinux.unstripped] Interrupt
make[1]: *** [/home/yhs/work/bpf-next/Makefile:1277: vmlinux] Interrupt
make: *** [/home/yhs/work/bpf-next/Makefile:248: __sub-make] Interrupt

I am using latest clang22 and latest pahole master (v1.31).

I will debug further from clang side.


>
> Thanks,
> --Nilay

