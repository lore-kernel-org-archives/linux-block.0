Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC/7EC55"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6FFEE;
	Wed,  6 Dec 2023 17:01:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso134385e87.0;
        Wed, 06 Dec 2023 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701910908; x=1702515708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+rXWANny0uHO6nzvjRs3/MCtnMqv7CRSnXsSEhy7sY=;
        b=WC/7EC55Tj0Ou8PbSnl8DdmwV11Ce8zbo/ZW1kQ2DKWp4ge902cWgWJKNJtoxvQfCx
         Bsn6ETtRJwi/qa+oHYVp6VUWnIhiqeV/FvVZw+hpXbw3onFaVontgpMEYyduXlX8jECj
         B6R95a1AjTVALf+XnN+jxGd6LVFCbY3w0KwgjoGqXSOB5pOicYTFhwHGrmSxnMFnrKwS
         LQv6l2InRCyI4FJpcqXQKdat5LAKrPWM7dRxI8WuDf2IFL7RlIojdovb7+5VGdzQIUpY
         dmSt/HOYAFHzmGyGEipO8MrLHkor2wdsj1CldLWCHpuCgk8FrkvrgA9IPE6VJC730DHW
         XrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701910908; x=1702515708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+rXWANny0uHO6nzvjRs3/MCtnMqv7CRSnXsSEhy7sY=;
        b=Ir1kKyY5SCVoKxLOhdp7W8yCoSPmkrZpKmHX52jZKwYWOCtn6b0J9m1hz2gCTH/wG0
         QV/pVmrRZLCPLX0abBsCHTaV2zZLHseWy/V7bvKROU+OigB9VC3eWlm3NjoWlXAYC0+f
         z5DTPH3t2QPvTjGWS+DsY/kgePqYsSNGlhwTb4zNdSD39qPRkOmAz5G3M6vRO5DSrsxE
         5654kTYi7q9vFz26URBnTWnbhx7mYKXQEvI4RLKX0npLjy+Wf5K91j7CmlTJW0MPT/Kc
         kGOMWaRA6CjWW420XZLBGAfL4X4u7CNjcGReR3P79IDIQiSQfvDHCcMG2F5Cbj9//sUS
         Sksw==
X-Gm-Message-State: AOJu0YzhRHSr7nCkhfKlhJys0wEt9jN9PZke/GLZgpkscRYz8jMZ73MW
	mUreWrkoZCx51KztccsYTt/kO8afeZpyEFwd48g=
X-Google-Smtp-Source: AGHT+IHzckmNKtnZ6eOoTsOs5qzRVqSfymWQafrRaRBqut1JkaNqKTmN853YKpOXutnsE06Us3WYqsyaEY388hz5RGY=
X-Received: by 2002:ac2:44d6:0:b0:50b:e750:dd99 with SMTP id
 d22-20020ac244d6000000b0050be750dd99mr1007855lfm.38.1701910907996; Wed, 06
 Dec 2023 17:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120083559.285174-1-ming.lei@redhat.com> <ZXEUyH/38KeATuF4@yury-ThinkPad>
 <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
In-Reply-To: <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
From: Yury Norov <yury.norov@gmail.com>
Date: Wed, 6 Dec 2023 17:01:36 -0800
Message-ID: <CAAH8bW-F6-uRHQ=c-C2pez365DbdRWn3izB9EmfBzvS+UHG3-A@mail.gmail.com>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug
 lock in group_cpus_evenly
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 4:54=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 6 Dec 2023 16:41:44 -0800 Yury Norov <yury.norov@gmail.com> wrote=
:
>
> > Although, it's not related to this patch directly. So, if you fix
> > zalloc_cpumask_var(), the patch looks good to me.
> >
> > Reviewed-by: Yury Norov <yury.norov@gmail.com>
>
> Thanks.
>
> I just moved this into mm.git's non-rebasing mm-hotfixes-stable branch,
> so I'd prefer not to have to redo it at this stage.
>
> Let's do these things (with which I agree) as a followup patch, please.

Sure, I can do that, and append to my series.
