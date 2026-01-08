Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD38320CCC
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767909047; cv=none; b=ZkJ+2co0Z2C+T9SEBMP9taogNDyALvYKPwAdN2ma4CAqVvnzkRp1jtaBaLiaZ2Cv3CsXQh11p7XYh2rXZdtkc2eMX3EH3R6eVxVzLQWhfFVrjtcqLeo1daZlTu0QPCfe7C++OzVC9JSrAwfXRfhA041Wm+bN8uEN7+biTLTUO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767909047; c=relaxed/simple;
	bh=qVMWLNKMWsnUnTE3cygtoEQsgpMSwvwyWMyFdDLzmDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btTHqEeXhyKdbtGypU5Y3eqxRVqRJzjHbElVp4RqkE3E+DxJFX5NkSLykE9uE2Oe/8LE+fG4U4ohP29nnFKqqT8gWNmmOKUDp3yBB9aqSROvdwmM6Jd6l0NIrVv+AFI6eyQ/952o38rWbnQfD3prdVGYvlnjAzIrvblRnsBG540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GxYEnov4; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GxYEnov4"
Message-ID: <f895a0ad-def6-4273-805c-40dc9d70bb20@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767909042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJYm4tSxp4AIUrSDeyjzY8bvrPMWr66Au4wlasTHx6U=;
	b=GxYEnov4fujVJUTDvLlSYBheqB/pt2yUgMmAODbC0DYLJhiZ8HffSsZiMhpb5oNKllzYib
	mjXUDnohmuRVH8mrJ7J9XTcxN2s7C6+x0+Rak/54cIui6C9QcoF6FN/cHIHajXHe+HENHZ
	eUB09S2eqs+7Uz/w1i0o7q3TfX0wKGo=
Date: Thu, 8 Jan 2026 13:50:15 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: kernel build failure when CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN
 are enabled
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>,
 Nilay Shroff <nilay@linux.ibm.com>
Cc: Alan Adamson <alan.adamson@oracle.com>, bpf@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com>
 <aSgz3h0Ywa6i3gKT@krava> <214308ce-763c-47a8-8719-70564b3ef49c@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <214308ce-763c-47a8-8719-70564b3ef49c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/27/25 7:36 AM, Alan Maguire wrote:
> On 27/11/2025 11:19, Jiri Olsa wrote:
>> On Wed, Nov 26, 2025 at 03:59:28PM +0530, Nilay Shroff wrote:
>>> Hi,
>>>
>>> I am encountering the following build failures when compiling the kernel source checked out
>>> from the for-6.19/block branch [1]:
>>>
>>>    KSYMS   .tmp_vmlinux2.kallsyms.S
>>>    AS      .tmp_vmlinux2.kallsyms.o
>>>    LD      vmlinux.unstripped
>>>    BTFIDS  vmlinux.unstripped
>>> WARN: multiple IDs found for 'task_struct': 110, 3046 - using 110
>>> WARN: multiple IDs found for 'module': 170, 3055 - using 170
>>> WARN: multiple IDs found for 'file': 697, 3130 - using 697
>>> WARN: multiple IDs found for 'vm_area_struct': 714, 3140 - using 714
>>> WARN: multiple IDs found for 'seq_file': 1060, 3167 - using 1060
>>> WARN: multiple IDs found for 'cgroup': 2355, 3304 - using 2355
>>> WARN: multiple IDs found for 'inode': 553, 3339 - using 553
>>> WARN: multiple IDs found for 'path': 586, 3369 - using 586
>>> WARN: multiple IDs found for 'bpf_prog': 2565, 3640 - using 2565
>>> WARN: multiple IDs found for 'bpf_map': 2657, 3837 - using 2657
>>> WARN: multiple IDs found for 'bpf_link': 2849, 3965 - using 2849
>>> [...]
>>> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>>> make[2]: *** Deleting file 'vmlinux.unstripped'
>>> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
>>> make: *** [Makefile:248: __sub-make] Error 2
>>>
>>>
>>> The build failure appears after commit 42adb2d4ef24 (“fs: Add the __data_racy annotation
>>> to backing_dev_info.ra_pages”) and commit 935a20d1bebf (“block: Remove queue freezing
>>> from several sysfs store callbacks”). However, the root cause does not seem to be specific
>> yep, looks like __data_racy macro that adds 'volatile' to struct member is causing
>> the mismatch during deduplication
>>
>> when you enable KCSAN some objects may opt out from it (via KCSAN_SANITIZE := n or
>> such) and they will be compiled without __SANITIZE_THREAD__ macro defined which means
>> __data_racy will be empty .. and we will get 2 versions of 'struct backing_dev_info'
>> which cascades up to the task_struct and others
>>
>> not sure what's the best solution in here.. could we ignore volatile for
>> the field in the struct during deduplication?
>>
> Yeah, it seems like a slightly looser form of equivalence matching might be needed.
> The following libbpf change ignores modifiers in type equivalence comparison and
> resolves the issue for me. It might be too big a hammer though, what do folks think?
>
>  From 160fb6610d75d3cdc38a9729cc17875a302a7189 Mon Sep 17 00:00:00 2001
> From: Alan Maguire <alan.maguire@oracle.com>
> Date: Thu, 27 Nov 2025 15:22:04 +0000
> Subject: [RFC bpf-next] libbpf: BTF dedup should ignore modifiers in type
>   equivalence checks
>
> We see identical type problems in [1] as a result of an occasionally
> applied volatile modifier to kernel data structures. Such things can
> result from different header include patterns, explicit Makefile
> rules etc.  As a result consider types with modifiers (const, volatile,
> restrict, type tag) as equivalent for dedup equivalence testing purposes.
>
> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
>
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   tools/lib/bpf/btf.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index e5003885bda8..384194a6cdae 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4678,12 +4678,10 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>   	cand_kind = btf_kind(cand_type);
>   	canon_kind = btf_kind(canon_type);
>   
> -	if (cand_type->name_off != canon_type->name_off)
> -		return 0;
> -
>   	/* FWD <--> STRUCT/UNION equivalence check, if enabled */
> -	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
> -	    && cand_kind != canon_kind) {
> +	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD) &&
> +	    cand_type->name_off == canon_type->name_off &&
> +	    cand_kind != canon_kind) {
>   		__u16 real_kind;
>   		__u16 fwd_kind;
>   
> @@ -4700,7 +4698,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>   		return fwd_kind == real_kind;
>   	}
>   
> -	if (cand_kind != canon_kind)
> +	/*
> +	 * Types are considered equivalent if modifiers (const, volatile,
> +	 * restrict, type tag) are present for one but not the other.
> +	 */
> +	if (cand_kind != canon_kind) {
> +		__u32 next_cand_id = cand_id;
> +		__u32 next_canon_id = canon_id;
> +
> +		if (btf_is_mod(cand_type))
> +			next_cand_id = cand_type->type;
> +		if (btf_is_mod(canon_type))
> +			next_canon_id = canon_type->type;
> +		if (cand_id == next_cand_id && canon_id == next_canon_id)
> +			return 0;
> +		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
> +	}
> +
> +	if (cand_type->name_off != canon_type->name_off)
>   		return 0;
>   
>   	switch (cand_kind) {

Thanks Alan. I can confirm that this fixed clang build issue as well.

As I mentioned earlier, the clang based kernel build will hang with both
CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN enabled. I did a little bit
debugging and found the repeated logs for the following code (btf.c)
during dedup.

                                 if (cand_type->name_off) {
                                         pr_debug("%s '%s' size=%d vlen=%d cand_id[%u] canon_id[%u] shallow-equal but not equiv for field#%d '%s': %d\n",
                                                  cand_kind == BTF_KIND_STRUCT ? "STRUCT" : "UNION",
                                                  btf__name_by_offset(d->btf, cand_type->name_off),
                                                  cand_type->size, vlen, cand_id, canon_id, i,
                                                  btf__name_by_offset(d->btf, cand_m->name_off), eq);
                                 }

The following are some of logs:

...
libbpf: STRUCT 'static_call_key' size=16 vlen=2 cand_id[2719764] canon_id[1005933] shallow-equal but not equiv for field#1 '': 0
libbpf: STRUCT 'tracepoint' size=72 vlen=8 cand_id[2719744] canon_id[1005913] shallow-equal but not equiv for field#2 'static_call_key': 0
libbpf: STRUCT 'bpf_raw_event_map' size=32 vlen=4 cand_id[2722229] canon_id[1008430] shallow-equal but not equiv for field#0 'tp': 0
...
libbpf: STRUCT 'static_call_key' size=16 vlen=2 cand_id[2719764] canon_id[1005933] shallow-equal but not equiv for field#1 '': 0
libbpf: STRUCT 'tracepoint' size=72 vlen=8 cand_id[2719744] canon_id[1005913] shallow-equal but not equiv for field#2 'static_call_key': 0
libbpf: STRUCT 'bpf_raw_event_map' size=32 vlen=4 cand_id[2722229] canon_id[1008430] shallow-equal but not equiv for field#0 'tp': 0
...
libbpf: STRUCT 'static_call_key' size=16 vlen=2 cand_id[2719764] canon_id[1005933] shallow-equal but not equiv for field#1 '': 0
libbpf: STRUCT 'tracepoint' size=72 vlen=8 cand_id[2719744] canon_id[1005913] shallow-equal but not equiv for field#2 'static_call_key': 0
libbpf: STRUCT 'bpf_raw_event_map' size=32 vlen=4 cand_id[2722229] canon_id[1008430] shallow-equal but not equiv for field#0 'tp': 0
...

and looks they caused the infinite recursion.

Anyway, you above patch fixed the problem. Thanks!

