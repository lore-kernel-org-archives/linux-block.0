Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <67c17f61-e225-74ce-5803-8452c987a6a0@grimberg.me>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-4-git-send-email-sagi@grimberg.me> <20170704082232.GE29053@ming.t460p>
 <67c17f61-e225-74ce-5803-8452c987a6a0@grimberg.me>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 4 Jul 2017 18:38:45 +0800
Message-ID: <CACVXFVME92QBm=MCNr-0ZQnRynBA0av7Ms8Bx+muJc9=FJ3XGQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] nvme-loop: quiesce admin_q instead of stopping hw queues
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Ming Lei <ming.lei@redhat.com>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary="089e08208e98f748bc05537b7cfd"
List-ID: <linux-block@vger.kernel.org>

--089e08208e98f748bc05537b7cfd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017=E5=B9=B47=E6=9C=884=E6=97=A5 =E4=B8=8B=E5=8D=885:25=EF=BC=8C"Sagi Grim=
berg" <sagi@grimberg.me>=E5=86=99=E9=81=93=EF=BC=9A

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
>> index 3d51341e62ee..891002ee005f 100644
>> --- a/drivers/nvme/target/loop.c
>> +++ b/drivers/nvme/target/loop.c
>> @@ -434,7 +434,7 @@ static void nvme_loop_shutdown_ctrl(struct
>> nvme_loop_ctrl *ctrl)
>>         if (ctrl->ctrl.state =3D=3D NVME_CTRL_LIVE)
>>                 nvme_shutdown_ctrl(&ctrl->ctrl);
>>   -     blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
>> +       blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>>         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>>                                 nvme_cancel_request, &ctrl->ctrl);
>>         nvme_loop_destroy_admin_queue(ctrl);
>>
>
> Is the queue killed before calling nvme_loop_destroy_admin_queue()?
>

No, its not.


If not, simply quiescing and not unquiescing will hang in
> blk_cleanup_queue().
>

Why should it? blk_cleanup_queue does not hang, even under IO load...


After queue is quiesced, new req still can come in and be put into
sw queue or scheduler queue,
then these requests can't be
submitted and completed at all,
finally cleanup never returns.

--089e08208e98f748bc05537b7cfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">2017=E5=B9=B47=E6=9C=884=E6=97=A5 =E4=B8=8B=E5=8D=885:25=EF=BC=8C=
&quot;Sagi Grimberg&quot; &lt;<a href=3D"mailto:sagi@grimberg.me">sagi@grim=
berg.me</a>&gt;=E5=86=99=E9=81=93=EF=BC=9A<br type=3D"attribution"><blockqu=
ote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div class=3D"quoted-text"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c<br>
index 3d51341e62ee..891002ee005f 100644<br>
--- a/drivers/nvme/target/loop.c<br>
+++ b/drivers/nvme/target/loop.c<br>
@@ -434,7 +434,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ct=
rl *ctrl)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctrl-&gt;ctrl.state =3D=3D NVME_CTRL_LIVE)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_shutdown_ctrl(=
&amp;ctrl-&gt;ctrl<wbr>);<br>
=C2=A0 -=C2=A0 =C2=A0 =C2=A0blk_mq_stop_hw_queues(ctrl-&gt;c<wbr>trl.admin_=
q);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0blk_mq_quiesce_queue(ctrl-&gt;ct<wbr>rl.admin_q=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_mq_tagset_busy_iter(&amp;ctrl-<wbr>&gt;admi=
n_tag_set,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_cancel_request, &amp;ctrl-&gt;c=
trl);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_loop_destroy_admin_queue(<wbr>ctrl);<br>
</blockquote>
<br>
Is the queue killed before calling nvme_loop_destroy_admin_queue(<wbr>)?<br=
>
</blockquote>
<br></div>
No, its not.<div class=3D"quoted-text"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
If not, simply quiescing and not unquiescing will hang in<br>
blk_cleanup_queue().<br>
</blockquote>
<br></div>
Why should it? blk_cleanup_queue does not hang, even under IO load...</bloc=
kquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Afte=
r queue is quiesced, new req still can come in and be put into</div><div di=
r=3D"auto">sw queue or scheduler queue,=C2=A0</div><div dir=3D"auto">then t=
hese requests can&#39;t be</div><div dir=3D"auto">submitted and completed a=
t all,</div><div dir=3D"auto">finally cleanup never returns.</div><div dir=
=3D"auto"><div class=3D"gmail_extra"><br></div></div></div>

--089e08208e98f748bc05537b7cfd--
