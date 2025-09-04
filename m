Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912431DED53
	for <linux-block@vger.kernel.org>; Thu,  4 Sep 2025 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961934; cv=none; b=JP4orBRZedT3dQtRwZlrzQaE1qmFUPRCjxcqw7Ax14cxRiVYQo6oiiZ9ZOrU95INqr2B4+HocadnZOMw9BkJuV+ML/FggmBLgAJ8uuLsFsS9rJig8SOv9WxRev2wGtSvn1KLepc2HmVkXZq8W5+9kp0Nz3aEHS42yryr2m7cJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961934; c=relaxed/simple;
	bh=ebnvjKIBK2/qzwXTlv+KsVV9YMjbcDc1wMGaeqNpL/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQ2KyRwbO8ErzOF7wX5uBy1L5lvWOoetexgiXMu9pcxY5qDP8x1j9BQlg1o2s/2PeIHuKMaraJvbeA3DQMdk9GdxeqV1uNVbne0jI1dFyPKmG/4Q04D0kiBcENOP4fkGWxoKRZjaE9QVPGE5wT5QXkCu8OMUDYYtWdy2w1fK2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0P4mtFB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0P4mtFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA1CC4CEF6;
	Thu,  4 Sep 2025 04:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756961934;
	bh=ebnvjKIBK2/qzwXTlv+KsVV9YMjbcDc1wMGaeqNpL/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I0P4mtFBr3D4+55yLQNGcrzaPiMqdoYT2MuZMHjElA6vQg+j5Zzv88+R3qklFpeBf
	 aHaRmN6MAE51Ys4fGZRmM74qA2nYZ9EZgYPoxC8w3jQ+n06JG7uM5irUx9Mu4K14Yi
	 pn9Mloi0X6MnOwVxFMNO5T7nOe1QJbY1tg8Ga1CdgUlilRFtvImdkJeKU3WWGlY3TH
	 lD96JJzjlg6bti+3WFM5dYtniJV4+uHrjmP+rkUharWZlr1REEZCvwC5OrG2yrbMG4
	 /9GAU1u2Zb3afUyiGUWf5VGzI0Xl11paveJoPn0qJIPIh64mSTaAFWFwSPHS8Oj6JQ
	 KQaUoZT+9F3LQ==
Message-ID: <e6cdf8c6-bc67-419b-8b79-d96e06bb7be7@kernel.org>
Date: Thu, 4 Sep 2025 13:55:54 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Sanitize set_task_ioprio() permission checks
To: Chen Yufeng <chenyufeng@iie.ac.cn>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250904031312.887-1-chenyufeng@iie.ac.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250904031312.887-1-chenyufeng@iie.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 12:13 PM, Chen Yufeng wrote:
> A patch similar to commit 197e7e521384("Sanitize 'move_pages()' permission 
> checks").
> 
> The set_task_ioprio function is responsible for setting the IO priority of a 
> specified process. The current implementation only checks if the target 
> process's uid matches the calling process's euid/uid, or if the caller has the 
> CAP_SYS_NICE capability. This permission check is too permissive and allows a 
> user to modify the IO priority of other processes with the same uid, including 
> privileged or system processes.
> 
> Local users can affect the IO scheduling of other processes with the same 
> uid, including suid binaries and system services, potentially causing denial 
> of service (DoS) or performance degradation.
> 
> So change the access checks to the more common 'ptrace_may_access()'
> model instead.
> 
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
> ---
>  block/blk-ioc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 9fda3906e5f5..bd3e556809c5 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -244,12 +244,9 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
>  int set_task_ioprio(struct task_struct *task, int ioprio)
>  {
>  	int err;
> -	const struct cred *cred = current_cred(), *tcred;
>  
>  	rcu_read_lock();
> -	tcred = __task_cred(task);
> -	if (!uid_eq(tcred->uid, cred->euid) &&
> -	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
> +	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {

The description of commit 197e7e521384 explicitely mentions that changing the
CAP_SYS_NICE check for that system call into CAP_SYS_PTRACE should be OK
because hardly anyone use that system call.

I do not think that the same can be said of the nice() and ioprio_set() system
calls. So dropping the capable(CAP_SYS_NICE) check seems wrong, unless you can
actually justify that it is safe ?

Lots of production systems out there use IO priority. We do not want these to
suddenly stop working because of a permission denied.

>  		rcu_read_unlock();
>  		return -EPERM;
>  	}


-- 
Damien Le Moal
Western Digital Research
