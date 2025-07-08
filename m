Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB511C6FF6
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935944; cv=none; b=oK49xs9h1VbaL22QSkPtZBXhGUtfU9EZ9h1LDUyqcFH4YLyn3T32Nd16Z8yH9BM5pQtpkYlmb9+ZBhJBzIMs1yHrkIcbCYRBj18Pp8lO/PaaCsM0EAOzx8ZR9VsIlqrEGS/FEyVUO635vELh8VlhkXq93J7Km8wjzoinG+pD1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935944; c=relaxed/simple;
	bh=L71YvKdbsnyzSxctlheGIVhUWFL7HKw4lIVFEzCDGus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHP1kgd6RxM4V+geHHUaNM76ezLdIOgIlmb78wrIvSYxjAIGXfhc4M8/M78u+Hr7oHQ9SIaSHlXHcd6nt8U04ZdQY3Kp/VwVx2KpEGJ3pO3KUqRmKwGHBUd2x5zI/aCPoobg/2czBzztAWe81si55Q5z67xePLLMfB6IPgw8mbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5680qJLw054763;
	Tue, 8 Jul 2025 09:52:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5680qJRE054758
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 8 Jul 2025 09:52:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b8769d22-fa19-4374-bbcc-be3f06f420bf@I-love.SAKURA.ne.jp>
Date: Tue, 8 Jul 2025 09:52:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
To: Hillf Danton <hdanton@sina.com>, Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
References: <20250707005946.2669-1-hdanton@sina.com>
 <20250708001848.2775-1-hdanton@sina.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250708001848.2775-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/08 9:18, Hillf Danton wrote:
> On Mon, 7 Jul 2025 10:39:44 -0700 Bart Van Assche wrote:
>> On 7/6/25 5:59 PM, Hillf Danton wrote:
>>> and given the second one, the report is false positive.
>>
>> Whether or not this report is a false positive, the root cause should be
>> fixed because lockdep disables itself after the first circular locking
>> complaint. From print_usage_bug() in kernel/locking/lockdep.c:
>>
>> 	if (!debug_locks_off() || debug_locks_silent)
>> 		return;
>>
> The root cause could be walked around for example by trying not to init
> nbd more than once.

How did you come to think so?

nbd_init() is already called only once because of module_init(nbd_init).

