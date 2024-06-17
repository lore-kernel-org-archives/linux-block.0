Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAF157A41;
	Mon, 17 Jun 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643784; cv=none; b=XZhi8G8XaOxchboeaN/wU2rr60E63mC3hqQv38RPRNxAouA1DarZHQQMJwYX9jJ742jehNDj8P16qDTKNv9K7bbxCBdu9fyE4BVAiPaGsFwCozlVb7Rf7i6HDgcXdwBn8pEf6N+LeMYjF8A1mq1soBwCvGYfyKBodI7I0Uk6QAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643784; c=relaxed/simple;
	bh=SgyQbzzcdBXXmyOpRsMu2bwCZ1cBAWRPxcqyPjOhikg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2J6nO4GswD9CR6ROQA4g9xcRp8xzfBRk6NL8hSENB6G78JXMJaJtogz2UMdwH+LZadrgH3Cn4+3raddEaliEOETg+uiB2VYdKO38CwY0GofaOKjaZ/DhtcnblNLPLv1cwqE6vcrMEM2vjiU7saj22aOFR1MHy94R2CkLg6CCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KBNld+85; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KBNld+85"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W2x5r101fz6Cnk97;
	Mon, 17 Jun 2024 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718643770; x=1721235771; bh=wnV5DGFlY55WTGNb14FMiJHz
	W0Mmlgovnem+iwBiibs=; b=KBNld+85Ri37EDRFTZaIQYwPF4WCHo0GxPB0YiBx
	epkAyShOgeWCeoJTqh4d8Kgwq9Hrk6HgiJgA+clxoROlmzeL7SaozFifYvq/2+eo
	kC+HWkvfzvy4JTDosOLjM6fFBKrDNzD0KuCyY14LEsPHM5ObjBnIWfUsAhYv0x1a
	tMVCG18I8tGk+IJMPpumXMngqn5FD1/XJX2oXdNgp1/fspi8djvwEagPfewfwaNn
	e6fGGuZD6YDQ/7GYVOnezG0tHMt9cKbmTyWGYPFya4TyHRcw1cOy8pViebZgNydE
	rI1UlGuwJViiRkacVnML9HluQJgzm/C3FIMDka2EBekUvg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZLo67KyiN4eh; Mon, 17 Jun 2024 17:02:50 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W2x5j1PJvz6Cnk95;
	Mon, 17 Jun 2024 17:02:48 +0000 (UTC)
Message-ID: <84e024ba-b921-481c-a83d-eec0dd0e8328@acm.org>
Date: Mon, 17 Jun 2024 10:02:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: Add ioprio to block_rq tracepoint
To: dongliang cui <cuidongliang390@gmail.com>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 ebiggers@kernel.org, ke.wang@unisoc.com, hongyu.jin.cn@gmail.com,
 niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com
References: <20240614074936.113659-1-dongliang.cui@unisoc.com>
 <7d0f68b8-ecdb-45fb-ae10-954eac5ed32c@acm.org>
 <CAPqOJe1=+dqcapg-_Y+Fq9W61wDMMzDLzP+CQqcTW69WdKQqRw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPqOJe1=+dqcapg-_Y+Fq9W61wDMMzDLzP+CQqcTW69WdKQqRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 6/17/24 12:59 AM, dongliang cui wrote:
> On Sat, Jun 15, 2024 at 12:41=E2=80=AFAM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>>
>> On 6/14/24 12:49 AM, Dongliang Cui wrote:
>>> -     TP_printk("%d,%d %s (%s) %llu + %u [%d]",
>>> +     TP_printk("%d,%d %s (%s) %llu + %u %s,%u,%u [%d]",
>>>                  MAJOR(__entry->dev), MINOR(__entry->dev),
>>>                  __entry->rwbs, __get_str(cmd),
>>> -               (unsigned long long)__entry->sector,
>>> -               __entry->nr_sector, 0)
>>> +               (unsigned long long)__entry->sector, __entry->nr_sect=
or,
>>> +               __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
>>> +                                IOPRIO_CLASS_STRINGS),
>>> +               IOPRIO_PRIO_HINT(__entry->ioprio),
>>> +               IOPRIO_PRIO_LEVEL(__entry->ioprio),  0)
>>>    );
>>
>> Do we really want to include the constant "[0]" in the tracing output?
> This is how it is printed in the source code.
>  From the code flow point of view, there is no need to print this value
> in trace_block_rq_requeue.
> Do we need to consider the issue of uniform printing format? If not, I
> think we can delete it.

I'm not aware of any other tracing statement that prints out a constant.
Is there perhaps something that I'm missing or overlooking?

Thanks,

Bart.

