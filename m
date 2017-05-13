Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <886609A4-9996-410F-8BB4-65B23866B31D@linaro.org>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
 <20170502080044.GA292@x4> <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com>
 <20170502121605.GA294@x4> <CA+icZUUJor+TK18ac8CepUd26ehcTijaA7NAmQxqW4b8yGJpzg@mail.gmail.com>
 <20170503091628.GB292@x4> <886609A4-9996-410F-8BB4-65B23866B31D@linaro.org>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sat, 13 May 2017 09:54:54 +0200
Message-ID: <CA+icZUXNbdjLwsSTnGQPdhKe1RVkMF1D1yEOVhx2LZ+kswFOVA@mail.gmail.com>
Subject: Re: Playing with BFQ
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Content-Type: multipart/mixed; boundary="001a113ef516393cbb054f6323c0"
List-ID: <linux-block@vger.kernel.org>

--001a113ef516393cbb054f6323c0
Content-Type: text/plain; charset="UTF-8"

On Wed, May 3, 2017 at 11:24 AM, Paolo Valente <paolo.valente@linaro.org> wrote:
>
>> Il giorno 03 mag 2017, alle ore 11:16, Markus Trippelsdorf <markus@trippelsdorf.de> ha scritto:
>>
>> On 2017.05.03 at 10:00 +0200, Sedat Dilek wrote:
>>> On Tue, May 2, 2017 at 2:16 PM, Markus Trippelsdorf
>>> <markus@trippelsdorf.de> wrote:
>>>> On 2017.05.02 at 14:07 +0200, Sedat Dilek wrote:
>>>>> On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
>>>>> <markus@trippelsdorf.de> wrote:
>>>>>> On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I want to play with BFQ.
>>>>>>>
>>>>>>> My base is block-next as of 28-Apr-2017.
>>>>> [...]
>>>>>>> Not sure if the attached patches make sense (right now).
>>>>>>
>>>>>> No, it doesn't make sense at all.
>>>>>
>>>>> Hmm, I looked at 4.11.0-v8r11 and 0001 has exactly what my 2 patches do :-).
>>>>
>>>> BFQ started as a conventional scheduler. But because mq is the way of
>>>> the future it was ported before it was accepted into mainline.
>>>>
>>>
>>> I am still playing and want to do my own experiences with BFQ.
>>>
>>> Not sure if FIO is a good testcase-tool here.
>>>
>>> So if MQ is the way why isn't the Kconfig called CONFIG_MQ_IOSCHED_BFQ
>>> according to CONFIG_MQ_IOSCHED_DEADLINE?
>>
>> Good point. The current naming is confusing.
>>
>> Also:
>> # cat /sys/block/sda/queue/scheduler
>> mq-deadline [kyber] bfq none
>>
>> These should all be prefixed with mq-.
>>
>
> The logic here, as proposed by Jens, is not to add the mq tag when
> there is no risk of ambiguity (such as between deadline and
> mq-deadline). I'm open to any sensible choice.
>

The naming is confusing but I can understand the point of Jens.

The Kconfigs of BFQ in block/Kconfig.iosched need a move (see my two
patches attached in the initial posting).
AFAICS you have the same in your latest BFQ-patchset for Linux v4.11.y.

I am re-attaching my two patches.

- Sedat -

--001a113ef516393cbb054f6323c0
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-block-bfq-Move-CONFIG_IOSCHED_BFQ-and-CONFIG_BFQ_GRO.patch"
Content-Disposition: attachment;
	filename="0001-block-bfq-Move-CONFIG_IOSCHED_BFQ-and-CONFIG_BFQ_GRO.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j2mz765x0

RnJvbSA3ZDkyMjMwMmEzYWY4OTM0ZGE0NmU4ZmMwNGQyNTYwMjVkOGRkYjI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDIgTWF5IDIwMTcgMDk6MzE6MzcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBibG9j
azogYmZxOiBNb3ZlIENPTkZJR19JT1NDSEVEX0JGUSBhbmQKIENPTkZJR19CRlFfR1JPVVBfSU9T
Q0hFRAoKLS0tCiBibG9jay9LY29uZmlnLmlvc2NoZWQgfCA0MCArKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwg
MjAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svS2NvbmZpZy5pb3NjaGVkIGIvYmxv
Y2svS2NvbmZpZy5pb3NjaGVkCmluZGV4IGZkMmNlZmE0N2QzNS4uOGVhMmM4ZDc3MTAwIDEwMDY0
NAotLS0gYS9ibG9jay9LY29uZmlnLmlvc2NoZWQKKysrIGIvYmxvY2svS2NvbmZpZy5pb3NjaGVk
CkBAIC0zOSw2ICszOSwyNiBAQCBjb25maWcgQ0ZRX0dST1VQX0lPU0NIRUQKIAktLS1oZWxwLS0t
CiAJICBFbmFibGUgZ3JvdXAgSU8gc2NoZWR1bGluZyBpbiBDRlEuCiAKK2NvbmZpZyBJT1NDSEVE
X0JGUQorICAgICAgICB0cmlzdGF0ZSAiQkZRIEkvTyBzY2hlZHVsZXIiCisgICAgICAgIGRlZmF1
bHQgbgorICAgICAgICAtLS1oZWxwLS0tCisgICAgICAgIEJGUSBJL08gc2NoZWR1bGVyIGZvciBC
TEstTVEuIEJGUSBkaXN0cmlidXRlcyB0aGUgYmFuZHdpZHRoIG9mCisgICAgICAgIG9mIHRoZSBk
ZXZpY2UgYW1vbmcgYWxsIHByb2Nlc3NlcyBhY2NvcmRpbmcgdG8gdGhlaXIgd2VpZ2h0cywKKyAg
ICAgICAgcmVnYXJkbGVzcyBvZiB0aGUgZGV2aWNlIHBhcmFtZXRlcnMgYW5kIHdpdGggYW55IHdv
cmtsb2FkLiBJdAorICAgICAgICBhbHNvIGd1YXJhbnRlZXMgYSBsb3cgbGF0ZW5jeSB0byBpbnRl
cmFjdGl2ZSBhbmQgc29mdAorICAgICAgICByZWFsLXRpbWUgYXBwbGljYXRpb25zLiAgRGV0YWls
cyBpbgorICAgICAgICBEb2N1bWVudGF0aW9uL2Jsb2NrL2JmcS1pb3NjaGVkLnR4dAorCitjb25m
aWcgQkZRX0dST1VQX0lPU0NIRUQKKyAgICAgICBib29sICJCRlEgaGllcmFyY2hpY2FsIHNjaGVk
dWxpbmcgc3VwcG9ydCIKKyAgICAgICBkZXBlbmRzIG9uIElPU0NIRURfQkZRICYmIEJMS19DR1JP
VVAKKyAgICAgICBkZWZhdWx0IG4KKyAgICAgICAtLS1oZWxwLS0tCisKKyAgICAgICBFbmFibGUg
aGllcmFyY2hpY2FsIHNjaGVkdWxpbmcgaW4gQkZRLCB1c2luZyB0aGUgYmxraW8KKyAgICAgICAo
Y2dyb3Vwcy12MSkgb3IgaW8gKGNncm91cHMtdjIpIGNvbnRyb2xsZXIuCisKIGNob2ljZQogCiAJ
cHJvbXB0ICJEZWZhdWx0IEkvTyBzY2hlZHVsZXIiCkBAIC03OSwyNiArOTksNiBAQCBjb25maWcg
TVFfSU9TQ0hFRF9LWUJFUgogCSAgc3luY2hyb25vdXMgd3JpdGVzLCBpdCB3aWxsIHNlbGYtdHVu
ZSBxdWV1ZSBkZXB0aHMgdG8gYWNoaWV2ZSB0aGF0CiAJICBnb2FsLgogCi1jb25maWcgSU9TQ0hF
RF9CRlEKLQl0cmlzdGF0ZSAiQkZRIEkvTyBzY2hlZHVsZXIiCi0JZGVmYXVsdCBuCi0JLS0taGVs
cC0tLQotCUJGUSBJL08gc2NoZWR1bGVyIGZvciBCTEstTVEuIEJGUSBkaXN0cmlidXRlcyB0aGUg
YmFuZHdpZHRoIG9mCi0Jb2YgdGhlIGRldmljZSBhbW9uZyBhbGwgcHJvY2Vzc2VzIGFjY29yZGlu
ZyB0byB0aGVpciB3ZWlnaHRzLAotCXJlZ2FyZGxlc3Mgb2YgdGhlIGRldmljZSBwYXJhbWV0ZXJz
IGFuZCB3aXRoIGFueSB3b3JrbG9hZC4gSXQKLQlhbHNvIGd1YXJhbnRlZXMgYSBsb3cgbGF0ZW5j
eSB0byBpbnRlcmFjdGl2ZSBhbmQgc29mdAotCXJlYWwtdGltZSBhcHBsaWNhdGlvbnMuICBEZXRh
aWxzIGluCi0JRG9jdW1lbnRhdGlvbi9ibG9jay9iZnEtaW9zY2hlZC50eHQKLQotY29uZmlnIEJG
UV9HUk9VUF9JT1NDSEVECi0gICAgICAgYm9vbCAiQkZRIGhpZXJhcmNoaWNhbCBzY2hlZHVsaW5n
IHN1cHBvcnQiCi0gICAgICAgZGVwZW5kcyBvbiBJT1NDSEVEX0JGUSAmJiBCTEtfQ0dST1VQCi0g
ICAgICAgZGVmYXVsdCBuCi0gICAgICAgLS0taGVscC0tLQotCi0gICAgICAgRW5hYmxlIGhpZXJh
cmNoaWNhbCBzY2hlZHVsaW5nIGluIEJGUSwgdXNpbmcgdGhlIGJsa2lvCi0gICAgICAgKGNncm91
cHMtdjEpIG9yIGlvIChjZ3JvdXBzLXYyKSBjb250cm9sbGVyLgotCiBlbmRtZW51CiAKIGVuZGlm
Ci0tIAoyLjExLjAKCg==
--001a113ef516393cbb054f6323c0
Content-Type: text/x-patch; charset="US-ASCII";
	name="0002-block-bfq-Introduce-DEFAULT_BFQ.patch"
Content-Disposition: attachment;
	filename="0002-block-bfq-Introduce-DEFAULT_BFQ.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j2mz7al01

RnJvbSBkYTMzNzk0MjRmYzAyMzdkNWRlMjVlOTQ2ZWQ1NDgyYTYyNWFhYWMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDIgTWF5IDIwMTcgMDk6MzM6MjcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBibG9j
azogYmZxOiBJbnRyb2R1Y2UgREVGQVVMVF9CRlEKCi0tLQogYmxvY2svS2NvbmZpZy5pb3NjaGVk
IHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
YmxvY2svS2NvbmZpZy5pb3NjaGVkIGIvYmxvY2svS2NvbmZpZy5pb3NjaGVkCmluZGV4IDhlYTJj
OGQ3NzEwMC4uZjM3NDU1ZGNmMzgxIDEwMDY0NAotLS0gYS9ibG9jay9LY29uZmlnLmlvc2NoZWQK
KysrIGIvYmxvY2svS2NvbmZpZy5pb3NjaGVkCkBAIC03Myw2ICs3Myw5IEBAIGNob2ljZQogCWNv
bmZpZyBERUZBVUxUX0NGUQogCQlib29sICJDRlEiIGlmIElPU0NIRURfQ0ZRPXkKIAorCWNvbmZp
ZyBERUZBVUxUX0JGUQorCQlib29sICJCRlEiIGlmIElPU0NIRURfQkZRPXkKKwogCWNvbmZpZyBE
RUZBVUxUX05PT1AKIAkJYm9vbCAiTm8tb3AiCiAKQEAgLTgyLDYgKzg1LDcgQEAgY29uZmlnIERF
RkFVTFRfSU9TQ0hFRAogCXN0cmluZwogCWRlZmF1bHQgImRlYWRsaW5lIiBpZiBERUZBVUxUX0RF
QURMSU5FCiAJZGVmYXVsdCAiY2ZxIiBpZiBERUZBVUxUX0NGUQorCWRlZmF1bHQgImJmcSIgaWYg
REVGQVVMVF9CRlEKIAlkZWZhdWx0ICJub29wIiBpZiBERUZBVUxUX05PT1AKIAogY29uZmlnIE1R
X0lPU0NIRURfREVBRExJTkUKLS0gCjIuMTEuMAoK
--001a113ef516393cbb054f6323c0--
