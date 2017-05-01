Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31179 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdEAQ2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2017 12:28:40 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "markus@trippelsdorf.de" <markus@trippelsdorf.de>
Subject: Re: [PATCH cosmetic] Remove trailing newline in elevator switch error
 message
Date: Mon, 1 May 2017 15:18:48 +0000
Message-ID: <1493651927.2665.3.camel@sandisk.com>
References: <20170429053808.GA293@x4>
In-Reply-To: <20170429053808.GA293@x4>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-04-29 at 07:38 +0200, Markus Trippelsdorf wrote:
> Trying to switch to a non-existing elevator currently results in garbled
> dmesg output, e.g.:
>=20
>  # echo "foo" > /sys/block/sda/queue/scheduler=20
>=20
> elevator: type foo not found
> elevator: switch to foo
>  failed
>=20
> (note the unintended line break.)
>=20
> Fix by stripping the trailing newline.
>=20
> diff --git a/block/elevator.c b/block/elevator.c
> index bf11e70f008b..4f13fcd3c626 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -1112,6 +1112,7 @@ static inline bool elv_support_iosched(struct reque=
st_queue *q)
>  ssize_t elv_iosched_store(struct request_queue *q, const char *name,
>  			  size_t count)
>  {
> +	char elevator_name[ELV_NAME_MAX];
>  	int ret;
> =20
>  	if (!(q->mq_ops || q->request_fn) || !elv_support_iosched(q))
> @@ -1121,7 +1122,9 @@ ssize_t elv_iosched_store(struct request_queue *q, =
const char *name,
>  	if (!ret)
>  		return count;
> =20
> -	printk(KERN_ERR "elevator: switch to %s failed\n", name);
> +	strlcpy(elevator_name, name, sizeof(elevator_name));
> +	strstrip(elevator_name);
> +	printk(KERN_ERR "elevator: switch to %s failed\n", elevator_name);
>  	return ret;
>  }

Hello Markus,

Your patch duplicates the code to remove trailing whitespace which is not
very elegant. Please move the code that removes trailing whitespace from
__elevator_change() into  elv_iosched_store() instead of duplicating it.

Thanks,

Bart.=20
