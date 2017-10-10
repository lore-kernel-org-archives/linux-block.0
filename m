Return-Path: <kyle.fortin@oracle.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] block: add partition uuid into uevent as "PARTUUID"
From: Kyle Fortin <kyle.fortin@oracle.com>
In-Reply-To: <150729013610.744480.1644359289262914898.stgit@buzz>
Date: Tue, 10 Oct 2017 16:57:07 -0400
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Message-Id: <B8DD6C03-B98F-4B74-A6A5-39219C470575@oracle.com>
References: <150729013610.744480.1644359289262914898.stgit@buzz>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
List-ID: <linux-block@vger.kernel.org>

Hi Konstantin,

> On Oct 6, 2017, at 7:42 AM, Konstantin Khlebnikov =
<khlebnikov@yandex-team.ru> wrote:
>=20
> Both most common formats have uuid in addition to partition name:
> GPT: standard uuid xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
> DOS: 4 byte disk signature and 1 byte partition xxxxxxxx-xx
>=20
> Tools from util-linux use the same notation for them.
>=20
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
> block/partition-generic.c |    2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 88c555db4e5d..8f8b580aee16 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -226,6 +226,8 @@ static int part_uevent(struct device *dev, struct =
kobj_uevent_env *env)
> 	add_uevent_var(env, "PARTN=3D%u", part->partno);
> 	if (part->info && part->info->volname[0])
> 		add_uevent_var(env, "PARTNAME=3D%s", =
part->info->volname);
> +	if (part->info && part->info->uuid[0])
> +		add_uevent_var(env, "PARTUUID=3D%s", part->info->uuid);
> 	return 0;
> }

Looks fine.

Reviewed-by: Kyle Fortin <kyle.fortin@oracle.com>
