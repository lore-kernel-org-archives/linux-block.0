Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2AE98
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 09:59:17 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6cdd584591eso8669b3a.2
        for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 09:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701280757; x=1701885557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vkTaXniaGAvSm21emczN5ehpTFqbiqfFzWpTtQjBgg=;
        b=kWJb9m5xDdrTHo0MpqtjgyJAjSqHy8i+eyej9TgVeb1SMeso+1hHgBp8gC6Yk4UXRl
         BrIlDez1oOe+h6eK4JnHRThq5vDhfcpYYEXGZj7/KElQV1lwRSuKhTK35F5AKeTmIOAG
         srTrXSwb4CeSyniOolCsXgJPyFnchPgM3KClnisxzo8YJSSJgaXhP5oxBIkJhOj/i1gj
         kkFqXbPuyZ8MeorwroLSEvqNQviLHZd/jova0E3zmASS9qeX/tV3Puh7W8SceeIcMQBM
         71NeB4lfDt6XCdA6DBXl4S7GdOwgBMvF86GeZZkWCwI7d3rYI1MB8zLLmH07or1PxpMY
         yAog==
X-Gm-Message-State: AOJu0YwjfJhjYOO663nkI8q7JRGTSHyzCMslvS5hXInM8t/8AgQPN09c
	O9ePK3TRwT1+AyhMfWiezzSNUYlLFus=
X-Google-Smtp-Source: AGHT+IEq2ZLZthbCzJAVqPdMDUA4mNPBrjuPJ4xVKFSYt1ftxldOOnINnZeCFIJdE9SWQFnQLeUM9Q==
X-Received: by 2002:a05:6a20:c906:b0:187:a4df:4e57 with SMTP id gx6-20020a056a20c90600b00187a4df4e57mr18909548pzb.20.1701280757127;
        Wed, 29 Nov 2023 09:59:17 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:af8d:714d:9855:3f9d? ([2620:0:1000:8411:af8d:714d:9855:3f9d])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79252000000b006cbb56d4e58sm11087381pfp.65.2023.11.29.09.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 09:59:16 -0800 (PST)
Message-ID: <18ee474f-80fd-4a46-a8f2-0cc213618a43@acm.org>
Date: Wed, 29 Nov 2023 09:59:15 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop/009: require --option of udevadm control
 command
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Alyssa Ross <hi@alyssa.is>
References: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/29/23 03:36, Shin'ichiro Kawasaki wrote:
> The test case loop/009 calls udevadm control command with --ping option.
> When systemd version is prior to 241, udevadm control command does not
> support the option, and the test case fails. Check availability of the
> option to avoid the failure.
> 
> Link: https://github.com/osandov/blktests/issues/129
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/loop/009 | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/loop/009 b/tests/loop/009
> index 2b7a042..5c14758 100755
> --- a/tests/loop/009
> +++ b/tests/loop/009
> @@ -10,6 +10,12 @@ DESCRIPTION="check that LOOP_CONFIGURE sends uevents for partitions"
>   
>   QUICK=1
>   
> +requires() {
> +	if ! udevadm control --ping > /dev/null 2>&1; then
> +		SKIP_REASONS+=("udevadm control does not support --ping option")
> +	fi
> +}
> +
>   test() {
>   	echo "Running ${TEST_NAME}"
>   

Hmm ... why "> /dev/null 2>&1" instead of the shorter ">&/dev/null"?

Thanks,

Bart.
