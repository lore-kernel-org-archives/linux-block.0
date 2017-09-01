Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1504287714.14386.53.camel@wdc.com>
References: <20170830184211.12471-1-bart.vanassche@wdc.com>
 <20170830184211.12471-4-bart.vanassche@wdc.com> <C7E01FF1-7311-449B-A410-E5F5C7369B9A@linaro.org>
 <CAA70yB7tzAmCmxjc=JmcQt8xZ7xMbYoQKsfkxU+uUvtBt5SUEA@mail.gmail.com> <1504287714.14386.53.camel@wdc.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Sat, 2 Sep 2017 02:06:49 +0800
Message-ID: <CAA70yB7_cMQahevon1f4Q2EK0rgNNuv7H1bfXBCvYEBsVL+WCA@mail.gmail.com>
Subject: Re: [PATCH 3/5] bfq: Check kstrtoul() return value
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

> Sorry but I do not like this proposal because:
> * If invalid input is provided writing into a sysfs attribute should fail
>   instead of ignoring the invalid input silently.
> * simple_strtoul() is considered obsolete and must not be used in new code.
>   From include/linux/kernel.h:
>
> /* Obsolete, do not use.  Use kstrto<foo> instead */
>
> extern unsigned long simple_strtoul(const char *,char **,unsigned int);
> extern long simple_strtol(const char *,char **,unsigned int);
> extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
> extern long long simple_strtoll(const char *,char **,unsigned int);
>

Hello Bart,

Agree with you, it seems more reasonable to give error message to user.

Thanks
