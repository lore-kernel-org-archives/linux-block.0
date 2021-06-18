Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBDFC48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D5E6128C
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhFRWcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:32:39 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:53863 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFRWcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 18:32:39 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20210618223028usoutp0274d242099822ef7583899d72a841d9c4~Jzc7SG1_R2878628786usoutp021;
        Fri, 18 Jun 2021 22:30:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20210618223028usoutp0274d242099822ef7583899d72a841d9c4~Jzc7SG1_R2878628786usoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624055428;
        bh=qMG0ntg42E9TPuRCRsW1HVr2BY0H+l+Uq6XQTtqigDI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WUd+UP1g73UWeK/xxt3Vza/wGnTpUgKGAB43s8Kr/MwQXDtr93O1p1BTrI9Vr/PAS
         NjhbX/eXbN4BTYqcT3awaDQxeq3aLX4cGmOAplugS37rAW9cN5RHXm3xg+FEn2taZH
         Cm62wJDYtMrtEgZbJ1gdWY367NBzdwjcJaTqKU0s=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618223028uscas1p1192b2a865f92e08a98ea9cb67937fd26~Jzc7Fkial2134821348uscas1p1o;
        Fri, 18 Jun 2021 22:30:28 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id DC.94.20835.48E1DC06; Fri,
        18 Jun 2021 18:30:28 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618223028uscas1p2f6a54a656ddcd232d086f26f2fddbe8b~Jzc6mDGPu2691526915uscas1p2c;
        Fri, 18 Jun 2021 22:30:28 +0000 (GMT)
X-AuditID: cbfec36d-cfbff70000015163-cf-60cd1e84ffcd
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id F9.38.47882.38E1DC06; Fri,
        18 Jun 2021 18:30:27 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 15:30:27 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 15:30:27 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 09/16] block/mq-deadline: Improve compile-time
 argument checking
Thread-Topic: [PATCH v3 09/16] block/mq-deadline: Improve compile-time
        argument checking
Thread-Index: AQHXY9s5mWnuxTNafkyvWDmKO4dZ2Ksa0LQA
Date:   Fri, 18 Jun 2021 22:30:27 +0000
Message-ID: <20210618223026.GA224281@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-10-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82BEDEDE33F4B945A73899A2C010138B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djX87otcmcTDPb+krNYfbefzWLah5/M
        FrNuv2axaG3/xmSxZ9EkJouVq48yWdxY8IbR4sn6WcwWf7vuMVnsvaVtcWhyM5MDt8flK94e
        l8+Wemxa1cnmsftmA5vHx6e3WDze77vK5rH5dLXH501yHu0HupkCOKO4bFJSczLLUov07RK4
        Mu50vWIpuBxVsWvGe/YGxpVeXYycHBICJhIrf91n7mLk4hASWMko8e7uNlaQhJBAK5PElxVl
        MEXz55xmhShayyjxZHcvG4TzkVFixbrFLBDOAUaJWUvb2UBa2AQMJH4f38gMYosIaEh8e7Ac
        rIhZYDmzxLJfZ9lBEsICkRLrFvayQhRFSSx/9QbKNpI4t/ElC4jNIqAq8XPTfrA4r4CpxMtt
        V4B6OTg4BSwkdtzgBAkzCohJfD+1hgnEZhYQl7j1ZD4TxNmCEotm72GGsMUk/u16yAZhK0rc
        //6SHaJeR2LB7k9sELadxPIzD6Hi2hLLFr5mhlgrKHFy5hMWiF5JiYMrboD9IiEwmVPi9b+n
        UMtcJN6s2wS1TFpi+prLUEW7GCXmzP7ICuEcZpTYdGE5I0SVtcSNl12MExhVZiG5fBaSq2Yh
        uWoWkqtmIblqASPrKkbx0uLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMBkd/rf4dwdjDtufdQ7
        xMjEwXiIUYKDWUmElzPzTIIQb0piZVVqUX58UWlOavEhRmkOFiVx3k+GE+OFBNITS1KzU1ML
        UotgskwcnFINTFOS5N2OXs/8IOlmskJw52SHj6efGE3nFl/tm3jvxz+R1iS2rkAn+ctGP2eE
        KNS03WYSszv5KW+hQ/WdfwHLXQVLJyo8tjum8/mn5KxTdQIJJxddmpncOt9qde0Z5vd3Ume8
        33JyzpenXw4d+yJjO8mOZca68LlNOdMrHPMn5H+9fENMbN62MG32OxHtkgotip9WcN4qVjRS
        dH3dWerctD/0V5y58b5bB0q2ZgcKPbNtX5c1W9D4AGOjjPct+8dzbVgXfrQxVzB7pqZY7XrP
        Q/KBnPMDfVulgOWOWW/sYpiaXhz8KdHB4PH90ZLdKv+2PKt0cThcm3St8F9IgeI9h203zDYf
        9qiZUCpxInuxlRJLcUaioRZzUXEiAHcrgmHlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWS2cA0SbdZ7myCQfclK4vVd/vZLKZ9+Mls
        Mev2axaL1vZvTBZ7Fk1isli5+iiTxY0FbxgtnqyfxWzxt+sek8XeW9oWhyY3Mzlwe1y+4u1x
        +Wypx6ZVnWweu282sHl8fHqLxeP9vqtsHptPV3t83iTn0X6gmymAM4rLJiU1J7MstUjfLoEr
        407XK5aCy1EVu2a8Z29gXOnVxcjJISFgIjF/zmnWLkYuDiGB1YwSc6efZ4dwPjJKTD65hhHC
        OcAo0bnpDCNIC5uAgcTv4xuZQWwRAQ2Jbw+Ws4AUMQssZZaYsvw3WEJYIFJi0bKjUEVREvt/
        fmWEsI0kzm18yQJiswioSvzctJ8VxOYVMJV4ue0K1OodjBIH1u9l6mLk4OAUsJDYcYMTpIZR
        QEzi+6k1TCA2s4C4xK0n85kgfhCQWLLnPDOELSrx8vE/VghbUeL+95fsEPU6Egt2f2KDsO0k
        lp95CBXXlli28DUzxA2CEidnPmGB6JWUOLjiBssERolZSNbNQjJqFpJRs5CMmoVk1AJG1lWM
        4qXFxbnpFcXGeanlesWJucWleel6yfm5mxiBaeL0v8MxOxjv3fqod4iRiYPxEKMEB7OSCC9n
        5pkEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwesRPjhQTSE0tSs1NTC1KLYLJMHJxSDUznvCR4
        4x8Ui/g03frbGJifsUBiali33NaPKa+ijMoNJ0uwnHj58/SUytRFXPL8bxmCr+eZMTOJzyky
        env87dy+R2Xzqv159quXf++4sf2ISNCLC3kVDbHs4T7xHr/mXvLakfVs2e7ps79t51t1YKUY
        a0PR0tVehWpbLrYdm3dsz6bXTXU3Hs52Xrq3caVhdeaqHYscnkh3r113wW77Mw1tydXFjrn+
        /wt9ZBPOP1p66q/9A6fbqhyR3Os0NGIzf5cdbdOwT9wTqh6Sfk7GyvNEQcOF6X8n1r/Vy/XI
        vnjGSDL65EGlCz1Xb/5r/VlguIftWfYktk2tAjPvyN5QizsnmG1Tc/6F20fFL9vKODcrsRRn
        JBpqMRcVJwIALplOQ4IDAAA=
X-CMS-MailID: 20210618223028uscas1p2f6a54a656ddcd232d086f26f2fddbe8b
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004522uscas1p281e394d6b734365499144350beaaec1e
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004522uscas1p281e394d6b734365499144350beaaec1e@uscas1p2.samsung.com>
        <20210618004456.7280-10-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:49PM -0700, Bart Van Assche wrote:
> Modern compilers complain if an out-of-range value is passed to a functio=
n
> argument that has an enumeration type. Let the compiler detect out-of-ran=
ge
> data direction arguments instead of verifying the data_dir argument at
> runtime.
>=20
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 96 +++++++++++++++++++++++----------------------
>  1 file changed, 49 insertions(+), 47 deletions(-)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index d823ba7cb084..69126beff77d 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -35,6 +35,13 @@ static const int writes_starved =3D 2;    /* max times=
 reads can starve a write */
>  static const int fifo_batch =3D 16;       /* # of sequential requests tr=
eated as one
>  				     by the above parameters. For throughput. */
> =20
> +enum dd_data_dir {
> +	DD_READ		=3D READ,
> +	DD_WRITE	=3D WRITE,
> +};
> +
> +enum { DD_DIR_COUNT =3D 2 };
> +
>  struct deadline_data {
>  	/*
>  	 * run time data
> @@ -43,20 +50,20 @@ struct deadline_data {
>  	/*
>  	 * requests (deadline_rq s) are present on both sort_list and fifo_list
>  	 */
> -	struct rb_root sort_list[2];
> -	struct list_head fifo_list[2];
> +	struct rb_root sort_list[DD_DIR_COUNT];
> +	struct list_head fifo_list[DD_DIR_COUNT];
> =20
>  	/*
>  	 * next in sort order. read, write or both are NULL
>  	 */
> -	struct request *next_rq[2];
> +	struct request *next_rq[DD_DIR_COUNT];
>  	unsigned int batching;		/* number of sequential requests made */
>  	unsigned int starved;		/* times reads have starved writes */
> =20
>  	/*
>  	 * settings that change how the i/o scheduler behaves
>  	 */
> -	int fifo_expire[2];
> +	int fifo_expire[DD_DIR_COUNT];
>  	int fifo_batch;
>  	int writes_starved;
>  	int front_merges;
> @@ -97,7 +104,7 @@ deadline_add_rq_rb(struct deadline_data *dd, struct re=
quest *rq)
>  static inline void
>  deadline_del_rq_rb(struct deadline_data *dd, struct request *rq)
>  {
> -	const int data_dir =3D rq_data_dir(rq);
> +	const enum dd_data_dir data_dir =3D rq_data_dir(rq);
> =20
>  	if (dd->next_rq[data_dir] =3D=3D rq)
>  		dd->next_rq[data_dir] =3D deadline_latter_request(rq);
> @@ -169,10 +176,10 @@ static void dd_merged_requests(struct request_queue=
 *q, struct request *req,
>  static void
>  deadline_move_request(struct deadline_data *dd, struct request *rq)
>  {
> -	const int data_dir =3D rq_data_dir(rq);
> +	const enum dd_data_dir data_dir =3D rq_data_dir(rq);
> =20
> -	dd->next_rq[READ] =3D NULL;
> -	dd->next_rq[WRITE] =3D NULL;
> +	dd->next_rq[DD_READ] =3D NULL;
> +	dd->next_rq[DD_WRITE] =3D NULL;
>  	dd->next_rq[data_dir] =3D deadline_latter_request(rq);
> =20
>  	/*
> @@ -185,9 +192,10 @@ deadline_move_request(struct deadline_data *dd, stru=
ct request *rq)
>   * deadline_check_fifo returns 0 if there are no expired requests on the=
 fifo,
>   * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
>   */
> -static inline int deadline_check_fifo(struct deadline_data *dd, int ddir=
)
> +static inline int deadline_check_fifo(struct deadline_data *dd,
> +				      enum dd_data_dir data_dir)
>  {
> -	struct request *rq =3D rq_entry_fifo(dd->fifo_list[ddir].next);
> +	struct request *rq =3D rq_entry_fifo(dd->fifo_list[data_dir].next);
> =20
>  	/*
>  	 * rq is expired!
> @@ -203,19 +211,16 @@ static inline int deadline_check_fifo(struct deadli=
ne_data *dd, int ddir)
>   * dispatch using arrival ordered lists.
>   */
>  static struct request *
> -deadline_fifo_request(struct deadline_data *dd, int data_dir)
> +deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_di=
r)
>  {
>  	struct request *rq;
>  	unsigned long flags;
> =20
> -	if (WARN_ON_ONCE(data_dir !=3D READ && data_dir !=3D WRITE))
> -		return NULL;
> -
>  	if (list_empty(&dd->fifo_list[data_dir]))
>  		return NULL;
> =20
>  	rq =3D rq_entry_fifo(dd->fifo_list[data_dir].next);
> -	if (data_dir =3D=3D READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir =3D=3D DD_READ || !blk_queue_is_zoned(rq->q))
>  		return rq;
> =20
>  	/*
> @@ -223,7 +228,7 @@ deadline_fifo_request(struct deadline_data *dd, int d=
ata_dir)
>  	 * an unlocked target zone.
>  	 */
>  	spin_lock_irqsave(&dd->zone_lock, flags);
> -	list_for_each_entry(rq, &dd->fifo_list[WRITE], queuelist) {
> +	list_for_each_entry(rq, &dd->fifo_list[DD_WRITE], queuelist) {
>  		if (blk_req_can_dispatch_to_zone(rq))
>  			goto out;
>  	}
> @@ -239,19 +244,16 @@ deadline_fifo_request(struct deadline_data *dd, int=
 data_dir)
>   * dispatch using sector position sorted lists.
>   */
>  static struct request *
> -deadline_next_request(struct deadline_data *dd, int data_dir)
> +deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_di=
r)
>  {
>  	struct request *rq;
>  	unsigned long flags;
> =20
> -	if (WARN_ON_ONCE(data_dir !=3D READ && data_dir !=3D WRITE))
> -		return NULL;
> -
>  	rq =3D dd->next_rq[data_dir];
>  	if (!rq)
>  		return NULL;
> =20
> -	if (data_dir =3D=3D READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir =3D=3D DD_READ || !blk_queue_is_zoned(rq->q))
>  		return rq;
> =20
>  	/*
> @@ -276,7 +278,7 @@ deadline_next_request(struct deadline_data *dd, int d=
ata_dir)
>  static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  {
>  	struct request *rq, *next_rq;
> -	int data_dir;
> +	enum dd_data_dir data_dir;
> =20
>  	lockdep_assert_held(&dd->lock);
> =20
> @@ -289,9 +291,9 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)
>  	/*
>  	 * batches are currently reads XOR writes
>  	 */
> -	rq =3D deadline_next_request(dd, WRITE);
> +	rq =3D deadline_next_request(dd, DD_WRITE);
>  	if (!rq)
> -		rq =3D deadline_next_request(dd, READ);
> +		rq =3D deadline_next_request(dd, DD_READ);
> =20
>  	if (rq && dd->batching < dd->fifo_batch)
>  		/* we have a next request are still entitled to batch */
> @@ -302,14 +304,14 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd)
>  	 * data direction (read / write)
>  	 */
> =20
> -	if (!list_empty(&dd->fifo_list[READ])) {
> -		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[READ]));
> +	if (!list_empty(&dd->fifo_list[DD_READ])) {
> +		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_READ]));
> =20
> -		if (deadline_fifo_request(dd, WRITE) &&
> +		if (deadline_fifo_request(dd, DD_WRITE) &&
>  		    (dd->starved++ >=3D dd->writes_starved))
>  			goto dispatch_writes;
> =20
> -		data_dir =3D READ;
> +		data_dir =3D DD_READ;
> =20
>  		goto dispatch_find_request;
>  	}
> @@ -318,13 +320,13 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd)
>  	 * there are either no reads or writes have been starved
>  	 */
> =20
> -	if (!list_empty(&dd->fifo_list[WRITE])) {
> +	if (!list_empty(&dd->fifo_list[DD_WRITE])) {
>  dispatch_writes:
> -		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[WRITE]));
> +		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_WRITE]));
> =20
>  		dd->starved =3D 0;
> =20
> -		data_dir =3D WRITE;
> +		data_dir =3D DD_WRITE;
> =20
>  		goto dispatch_find_request;
>  	}
> @@ -399,8 +401,8 @@ static void dd_exit_sched(struct elevator_queue *e)
>  {
>  	struct deadline_data *dd =3D e->elevator_data;
> =20
> -	BUG_ON(!list_empty(&dd->fifo_list[READ]));
> -	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));
> +	BUG_ON(!list_empty(&dd->fifo_list[DD_READ]));
> +	BUG_ON(!list_empty(&dd->fifo_list[DD_WRITE]));
> =20
>  	kfree(dd);
>  }
> @@ -424,12 +426,12 @@ static int dd_init_sched(struct request_queue *q, s=
truct elevator_type *e)
>  	}
>  	eq->elevator_data =3D dd;
> =20
> -	INIT_LIST_HEAD(&dd->fifo_list[READ]);
> -	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);
> -	dd->sort_list[READ] =3D RB_ROOT;
> -	dd->sort_list[WRITE] =3D RB_ROOT;
> -	dd->fifo_expire[READ] =3D read_expire;
> -	dd->fifo_expire[WRITE] =3D write_expire;
> +	INIT_LIST_HEAD(&dd->fifo_list[DD_READ]);
> +	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);
> +	dd->sort_list[DD_READ] =3D RB_ROOT;
> +	dd->sort_list[DD_WRITE] =3D RB_ROOT;
> +	dd->fifo_expire[DD_READ] =3D read_expire;
> +	dd->fifo_expire[DD_WRITE] =3D write_expire;
>  	dd->writes_starved =3D writes_starved;
>  	dd->front_merges =3D 1;
>  	dd->fifo_batch =3D fifo_batch;
> @@ -497,7 +499,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
>  {
>  	struct request_queue *q =3D hctx->queue;
>  	struct deadline_data *dd =3D q->elevator->elevator_data;
> -	const int data_dir =3D rq_data_dir(rq);
> +	const enum dd_data_dir data_dir =3D rq_data_dir(rq);
> =20
>  	lockdep_assert_held(&dd->lock);
> =20
> @@ -585,7 +587,7 @@ static void dd_finish_request(struct request *rq)
> =20
>  		spin_lock_irqsave(&dd->zone_lock, flags);
>  		blk_req_zone_write_unlock(rq);
> -		if (!list_empty(&dd->fifo_list[WRITE]))
> +		if (!list_empty(&dd->fifo_list[DD_WRITE]))
>  			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
>  		spin_unlock_irqrestore(&dd->zone_lock, flags);
>  	}
> @@ -626,8 +628,8 @@ static ssize_t __FUNC(struct elevator_queue *e, char =
*page)		\
>  		__data =3D jiffies_to_msecs(__data);			\
>  	return deadline_var_show(__data, (page));			\
>  }
> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[READ], 1);
> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[WRITE], 1);
> +SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);
> +SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);
>  SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
>  SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
>  SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);
> @@ -649,8 +651,8 @@ static ssize_t __FUNC(struct elevator_queue *e, const=
 char *page, size_t count)
>  		*(__PTR) =3D __data;					\
>  	return count;							\
>  }
> -STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[READ], 0, IN=
T_MAX, 1);
> -STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[WRITE], 0, =
INT_MAX, 1);
> +STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0,=
 INT_MAX, 1);
> +STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], =
0, INT_MAX, 1);
>  STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, INT_M=
IN, INT_MAX, 0);
>  STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, 0);
>  STORE_FUNCTION(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX, 0=
);
> @@ -717,8 +719,8 @@ static int deadline_##name##_next_rq_show(void *data,=
			\
>  		__blk_mq_debugfs_rq_show(m, rq);			\
>  	return 0;							\
>  }
> -DEADLINE_DEBUGFS_DDIR_ATTRS(READ, read)
> -DEADLINE_DEBUGFS_DDIR_ATTRS(WRITE, write)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_READ, read)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_WRITE, write)
>  #undef DEADLINE_DEBUGFS_DDIR_ATTRS
> =20
>  static int deadline_batching_show(void *data, struct seq_file *m)

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
