Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF9409635
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164298; cv=none; b=JjBzJvAALYWenz64wQWAKAeSwLjAoIMUmqd/RBbKKu8BXV+oHKwLHnK8SfMavA4H9vEw2w44xD3BC/rsr0cvxKeGAovV6qrbuPJ8Rw50qFo2zniELjNYJOlTHaI0p1aeEdHL/dromh02m40ZJP4HFWsuUX9kTd2yuyoRISTFl64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164298; c=relaxed/simple;
	bh=/pHEhqhHim6zbvXlXGSytIteuWLfY5Kr9gwBWC8fFio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjuW+99uEnggCvVVNP7MWOWWwnScKqboQ3ATpqsmVftljFpHEZt8WysaMgS+RT0INucsT+ZEfGvgcRiMhE9X05xbJ2fvZmYZ8/psG/GuikpmCQ/aY4Ru4O+DK6AYxUUnYyUnGf8JG8kP29Vixi7imoeM8PCQdfRYEPrnQ7oRVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WtIrJspU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WtIrJspU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49553515a8bso33186705e9.1
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785164294; x=1785769094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=WtIrJspUFDv9uYL8E4OhCURfnCutsSkbOm+juL/6yCshO8FMCiFZrYMSEpcfsdW4Nh
         iKdHsW3hXXVC8Pl4kUTysqT9Zr8oF1RzlXcRzFSGc2UBRbewwmpIc4cUdB8jmp3pl1An
         f6O93wZ1uT86BMhjp0hkFyCYKEgWqWi968vQRJXARDoAz7+tu8TEFguRFWLq/na2hZxb
         h+/lKgJgJ7KvEmuOlPlx1TgAEAOP3gxpUS2jY/c4WBF4cEndQhBSKAsMyUFZVAH/YqQT
         oXvZ+5VFrjrP5i1FIj+Vs0SajlFsW+dWgVvOzDcsFpUW8FB2tzSLDDUFkca3REdCvM53
         ZAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164294; x=1785769094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=RREfEx24vORgnJ7sAoGxKvypPfdT7dos9D7PCIqYqzdOrSBhmDIxDc1l+B5aAxFgWe
         lHTvhqhT+eisidPdhZAasac79FQpOEBmlvN/Dsiv5PKWAkstALqQcRs1lFbsLfEdzhKY
         CVwp4sMIQcLpgHPw0RykknSX7Wgmo+6HSC9XZH2Y1AuPYNgtNFFPsiUSQq//+2M8knDg
         uZJLrimymDvQ1dzsi5ABwMm1ctsaao1Yc4Geox8XvI3U3xuBbKRiZAaYrvDgMTwvDK7H
         hueCUTXFaxi5HBOlysY4WkpZvibwFA/Iy5eX2p6Mey8XtLj7yavvjGbvmkiB9TMdwCVV
         q48A==
X-Forwarded-Encrypted: i=1; AHgh+Rr4wuB4tc1VtDd3Wsfy78uSlTNLzWs+T+ijHihXAkXfCnAUoAWpJ+YGfq5LAdxC+We5x6wmhHQPWfnnMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQdDUuhch9BahxM5XTT4DXPI5WopF0TbDkXPjxjO9bwUn8PpW
	ODNbp5cmSr0uccQp/F1S+ZwsrxLoe8f7SdQpmtOJiPnRVorqxl60bzBOxh7vRinjQXU=
X-Gm-Gg: AR+sD13JhcxcGGT7vIEXzyzaz5PvrxjXVWyJEXYENKjtl6Xbe33eusaCTmvJXPt3BoJ
	6tqRzWKj8UfTx5WF6OJ4gzM2WVd1oSRgi4cspU8cBL/dZNx7cAIU/tqJzz3o/yLNoifvCrCDnao
	C8dJuIuhK8Pm4R+/O4iDNqI0wmyYQX8LxGPKir4xAGtUpBmfLEQLr6NYhfrZha3h6HobpPCyUzO
	s/s8e19fEjOL/VWzhFd4zDo2vtHxnbRfJ2HIIBPsU/j8+W/YXpdVwhnaiS3voFJWLMkyadCnMbj
	ZIlcodNsTbXIxlV7wBry+BiIxLWF7mXwbRXuwMDeYFKXye3Fkg2pm754OAPeyDJeKn9AFwCZ75f
	cs5DpWhEUv757Po2u4yccCGNlyVaXpalbdubODHn/t1GMnEgCr61Bqt59qwjNI8lw8DcPPUR7hs
	purl18UOuhUbOf/BOgpmgwTOWwubbGecd/39+o3eU=
X-Received: by 2002:a05:600c:1553:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-496b5731987mr114339235e9.39.1785164294020;
        Mon, 27 Jul 2026 07:58:14 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee0e91sm231594995e9.4.2026.07.27.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:58:13 -0700 (PDT)
Message-ID: <ead73f81-26ef-4a46-9ad8-fcd2915563e1@suse.com>
Date: Mon, 27 Jul 2026 16:58:11 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
To: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260721131207.803760-1-petr.pavlu@suse.com>
 <20260721131207.803760-3-petr.pavlu@suse.com> <874ihmke0k.ffs@fw13>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <874ihmke0k.ffs@fw13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 10:31 PM, Thomas Gleixner wrote:
> On Tue, Jul 21 2026 at 15:11, Petr Pavlu wrote:
> 
>> The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
> 
> jiffies.c uses ...
> 
>> proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
>> proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
>> currently relies on this header being included indirectly through
>> linux/module.h -> linux/kmod.h. Add the missing include in preparation for
>> removing the linux/sysctl.h include from linux/kmod.h.
> 
> Can you please split that spaghetti sentence into paragraphs?
> 
> https://docs.kernel.org/process/maintainer-tip.html#changelog

I will update it to:

    jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
    proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
    which are declared in linux/sysctl.h. It currently gets that header
    indirectly through linux/module.h -> linux/kmod.h, but the latter no longer
    needs to include linux/sysctl.h.

    Include linux/sysctl.h directly in jiffies.c ahead of removing the
    unnecessary include from linux/kmod.h.

> 
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> Other than that.
> 
> Acked-by: Thomas Gleixner <tglx@kernel.org>

-- 
Thanks,
Petr
